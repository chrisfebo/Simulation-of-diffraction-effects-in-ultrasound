clear all
close all
clc

% create the computational grid
Nx = 400;           % number of grid points in the x (row) direction
Ny = 400;           % number of grid points in the y (column) direction
dx = 0.01;        % grid point spacing in the x direction [m]
dy = 0.01;        % grid point spacing in the y direction [m]
kgrid = kWaveGrid(Nx, dx, Ny, dy);


% create a sensor mask covering the entire computational domain using the
% opposing corners of a rectangle
sensor.mask = [1, 1, Nx, Ny].';

% set the record mode to capture the final wave-field and the statistics at
% each sensor point
sensor.record = {'p_final', 'p_max', 'p_rms','p'};

% define the ratio between the barrier and background sound speed and density
barrier_scale = 100;


% create a mask of a barrier with a slit
slit_thickness = 1;                     % [grid points]
slit_width = 20;                        % [grid points]
slit_x_pos = 39;                 % [grid points]
slit_offset = (Ny-slit_width)/2;  % [grid points]
slit_mask = zeros(Nx, Ny);
slit_mask(slit_x_pos:slit_x_pos + slit_thickness, 1:1 + slit_offset) = 1;
slit_mask(slit_x_pos:slit_x_pos + slit_thickness, end - slit_offset:end) = 1;
slit_mask(200:201, :) = 1;

% define the source wavelength to be the same as the slit size
%source_wavelength = slit_width * dx;    % [m]

% assign the slit to the properties of the propagation medium
c0 = 340; % [m/s]
rho0 = 1.225; 
medium.sound_speed = c0 * ones(Nx, Ny);
medium.density = rho0 * ones(Nx, Ny);
medium.sound_speed(slit_mask == 1) = barrier_scale * c0;
medium.density(slit_mask == 1) = (barrier_scale * rho0);

% find the time step at the stability limit
% assign the reference sound speed to the background medium
medium.sound_speed_ref = c0;
c_ref = c0;
c_max = barrier_scale * c0;
k_max = max(kgrid.k(:));
dt_limit = 2 / (c_ref * k_max) * asin(c_ref / c_max);

% create the time array, with the time step just below the stability limit
dt = 0.85 * dt_limit;   % [s]
t_end = 2.2732e-3;          % [s]
kgrid.setTime(round(t_end / dt), dt);

% define a single source point
source.p_mask = zeros(Nx, Ny);
source.p_mask(1, (Ny)/2) = 1;

% define a time varying sinusoidal source
source_freq = 50e3;   % [Hz]
source_mag = 20;         % [Pa]
%source.p = source_mag* sin(2 * pi * source_freq * kgrid.t_array);
source.p0 = source_mag*source.p_mask;


% set the input options
input_args = {'PMLInside', false, 'PMLSize', 20, 'PlotPML', false, ...
    'DisplayMask', slit_mask, 'DataCast', 'single'};

% run the simulation
sensor_data = kspaceFirstOrder2D(kgrid, medium, source, sensor, input_args{:});
