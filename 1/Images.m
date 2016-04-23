%
% Copyright 2016 Vienna University of Technology.
% Institute of Computer Graphics and Algorithms.
%

function[image_swapped, image_mark_green, image_masked, image_reshaped, image_convoluted, image_edge] = Images()

%% Initialization. Do not change anything here
input_path = 'lena_color.jpg';
output_path = 'lena_output.png';

image_swapped = [];
image_mark_green = [];
image_masked = [];
image_reshaped = [];
image_edge = [];

%% I. Images basics
% 1) Load image from 'input_path'

lena = imread(input_path);

% 2) Convert the image from 1) to double format with range [0, 1]. DO NOT USE LOOPS.

lena = im2double(lena);

% 3) Use the image from 2) to create an image where the red and the blue channel
% are swapped. The result should be stored in image_swapped. DO NOT USE LOOPS.

image_swapped(:, :, 1) = lena(:, :, 3);
image_swapped(:, :, 2) = lena(:, :, 2);
image_swapped(:, :, 3) = lena(:, :, 1);

% 4) Display the swapped image

figure, imshow(image_swapped);

% 5) Write the swapped image to the path specified in output_path. The
% image should be in png format.

imwrite(lena, output_path, 'png');

% 6) Create logical image where every pixel is marked that has a green channel
% which is greater or equal 0.5. The result should be stored in image_mark_green. 
% Use the image from step 2 for this step.
% DO NOT USE LOOPS.
% HINT:
% see http://de.mathworks.com/help/matlab/matlab_prog/find-array-elements-that-meet-a-condition.html).

image_mark_green = lena(:,:,2);
image_mark_green = im2bw(image_mark_green, 0.5);
image_mark_green = ~image_mark_green;

% 7) Set all pixels in the original image (the double image from step 2) to black where image_mark_green is
% true (where green >= 0.5). Store the result in image_masked. 
% Use repmat to complete this task. DO NOT USE LOOPS. 

image_masked = lena .* repmat(image_mark_green, [1 1 3]);

% 8) Convert the original image (the double image from step 2) to a grayscale image and reshape it from
% 512x512 to 256x1024. Cut off the right half of the image and attach it to the bottom of the left half.
% The result should be stored in 'image_reshaped' DO NOT USE LOOPS.
% (Hint: Matlab adresses matrices with "height x width". 
% 	     The dimensions in the instructions refer to the human-readable form "width x height".
%		 If this is not clear, take a look at the resulting image in the online-instructions.)

image_reshaped = rgb2gray(lena);
image_reshaped = vertcat(image_reshaped(:,1:256), image_reshaped(:,257:512));

%% II. Filters and convolutions

% 1) Use fspecial to create a 5x5 gaussian filter with sigma=2.0

gauss_kernel = fspecial('gaussian', [5, 5], 2);

% 2) Implement the evc_filter function. You are allowed to use loops for
% this task. You can assume that the kernel is always of size 5x5.
% For pixels outside the image use 0. 
% Do not use the conv or the imfilter or similar functions here. The result should be
% stored in image_convoluted
% The output image should have the same size as the input image.
image_convoluted = evc_filter(image_swapped, gauss_kernel);

% 3) Create a image showing the horizontal edges in image_reshaped using the sobel filter.
% For this task you can use imfilter/conv.
% Attention: Do not use evc_filter for this task!
% The result should be stored in image_edge. DO NOT USE LOOPS.
% The output image should have the same size as the input image.
% For this task it is your choice how you handle pixels outside the
% image, but you should use a typical method to do this.

image_edge = imfilter(image_reshaped, [ -1,  -2, -1;
                                         0,   0,  0;
                                         1,   2,  1], 'replicate');

end

% Returns the input image filtered with the kernel
% input: An rgb-image
% kernel: The filter kernel
function [result] = evc_filter(input, kernel)
    s = size(input);
    k = size(kernel, 1);
    l = floor(k / 2) + 1

    result = zeros(s);

    for x = 1:s(1)
        for y = 1:s(2)
            tmp = [0 0 0];
            for i = 1:k
                for j = 1:k
                    if (x - l + i < 1) | (x - l + i > s(1))
                        continue;
                    elseif (y - l + j < 1) | (y - l + j > s(2))
                        continue;
                    end
                    for c = 1:3
                        tmp(c) = tmp(c) + input(x - 3 + i, y - 3 + j, c) * kernel(i, j);
                    end
                end
            end
            result(x, y, :) = tmp(:);
        end
    end
end
