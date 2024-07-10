function data = readData(path)
    % Read ecg values and timestamps from file to array
    file = fopen(path, 'r'); % Open the file for reading
    if file == -1
        error('Error opening the file: %s', path);
    end
    
    formatSpec = '%f %f';
    sizeA = [2, Inf];
    d = fscanf(file, formatSpec, sizeA);
    fclose(file);
    data = d';
end
