classdef HX711Driver < realtime.internal.SourceSampleTime ...
        & coder.ExternalDependency ...
        & matlab.system.mixin.Propagates ...
        & matlab.system.mixin.CustomIcon

    %
    %   HX711 Driver for Raspberry Pi
    %
    % 	Author : Eisuke Matsuzaki
    % 	Created on : 07/01/2020
    % 	Copyright (c) 2020 d’Arbeloff Lab, MIT Department of Mechanical Engineering
    %   Released under the MIT license
    %

    properties
        % Public, tunable properties.
    end
    
    properties (Nontunable)
        % DOUT Pin Number
        doutPin = 17;
        % PD_SCK Pin Number
        sckPin = 27;
    end
    
    properties (Access = private)
        % Pre-computed constants.
    end
    
    methods
        % Constructor
        function obj = Source(varargin)
            % Support name-value pair arguments when constructing the object.
            setProperties(obj,nargin,varargin{:});
        end
    end
    
    methods (Access=protected)
        function setupImpl(obj) %#ok<MANU>
            if isempty(coder.target)
                % Place simulation setup code here
            else
                % Call C-function implementing device initialization
                coder.cinclude('hx711_raspi.h');
                coder.ceval('digitalIOSetup', obj.doutPin, obj.sckPin);
            end
        end
        
        function y = stepImpl(obj)   %#ok<MANU>
            y = uint32(0);
            if isempty(coder.target)
                % Place simulation output code here
            else
                % Call C-function implementing device output
                y = coder.ceval('getValue');
            end
        end
        
        function releaseImpl(obj) %#ok<MANU>
            if isempty(coder.target)
                % Place simulation termination code here
            else
                % Call C-function implementing device termination
                % No termination code for RaspberryPi
            end
        end
    end
    
    methods (Access=protected)
        %% Define output properties
        function num = getNumInputsImpl(~)
            num = 0;
        end
        
        function num = getNumOutputsImpl(~)
            num = 1;
        end
        
        function flag = isOutputSizeLockedImpl(~,~)
            flag = true;
        end
        
        function varargout = isOutputFixedSizeImpl(~,~)
            varargout{1} = true;
        end
        
        function flag = isOutputComplexityLockedImpl(~,~)
            flag = true;
        end
        
        function varargout = isOutputComplexImpl(~)
            varargout{1} = false;
        end
        
        function varargout = getOutputSizeImpl(~)
            varargout{1} = [1,1];
        end
        
        function varargout = getOutputDataTypeImpl(~)
            varargout{1} = 'uint32';
        end
        
        function icon = getIconImpl(~)
            % Define a string as the icon for the System block in Simulink.
            icon = 'HX711Driver';
        end    
        
        function outputName = getOutputNamesImpl(~)
            outputName = 'rawData';
        end
    end
    
    methods (Static, Access=protected)
        function simMode = getSimulateUsingImpl(~)
            simMode = 'Interpreted execution';
        end
        
        function isVisible = showSimulateUsingImpl
            isVisible = false;
        end
    end
    
    methods (Static)
        function name = getDescriptiveName()
            name = 'HX711Driver';
        end
        
        function b = isSupportedContext(context)
            b = context.isCodeGenTarget('rtw');
        end
        
        function updateBuildInfo(buildInfo, context)
            if context.isCodeGenTarget('rtw')
                % Update buildInfo
                srcDir = fullfile(fileparts(mfilename('fullpath')),'src'); %#ok<NASGU>
                includeDir = fullfile(fileparts(mfilename('fullpath')),'include');
                addIncludePaths(buildInfo,includeDir);
                % Use the following API's to add include files, sources and
                % linker flags
                addSourceFiles(buildInfo,'hx711_raspi.c', srcDir);
                addLinkFlags(buildInfo,'-lwiringPi');
            end
        end
    end
end
