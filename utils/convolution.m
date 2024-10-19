image = imread('images/1-1.jpg');
imshow(image);

G = 1/25 * [1 1 1 1 1; 1 1 1 1 1; 1 1 1 1 1; 1 1 1 1 1; 1 1 1 1 1];
H = [0 -1 0; -1 4 -1; 0 -1 0];
conv_image = convolutions(double(image), double(H));
figure; imshow(conv_image);

Ifiltered = uint8(convn(double(image), double(H)));
figure; imshow(Ifiltered)

function output_image = convolutions(image, convMatrix)
    [rows, cols, color_channels] = size(image);
    [rowsConv, colsConv] = size(convMatrix);
    disp(rowsConv);
    disp(colsConv);
    output_image = zeros(rows, cols, 'uint8');

    for i = ((rowsConv+1)/2):(rows-((rowsConv-1)/2))
        for j = ((colsConv+1)/2):(cols-((colsConv-1)/2))
            for k = 1:color_channels
                temp = 0;
                startIdxRow = i-(rowsConv+1)/2;
                startIdxCols = j-(colsConv+1)/2;
                for a = 1:rowsConv
                    for b = 1:colsConv
                        temp = temp + image(a + startIdxRow,b + startIdxCols,k)*convMatrix(a,b);
                    end
                end
                
                if temp < 0
                    output_image(i,j,k) = 0;
                elseif temp > 255
                    output_image(i,j,k) = 255;
                else
                    output_image(i,j,k) = uint8(temp);
                end
            end
        end
    end
end

