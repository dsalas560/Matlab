% Extract data from SV structure
SV_xyz = SV.xyz;
PR = SV.PR; % Pseudoranges
num_SVs = size(PR, 1);

% Extract data from User structure
User_xyz = User.xyz;

% Set tolerance as needed
tolerance = 1; % Adjust as required

% Initialize array to store calculated PRN
calculated_PRN = zeros(num_SVs, 1);

% Calculate distances between user position and SV positions
for i = 1:num_SVs
    % Calculate distance between user position and SV position
    distance = norm(SV_xyz(i, :) - User_xyz);
    
    % Compute expected pseudorange based on distance
    expected_PR = distance;
    
    % Find the PRN corresponding to the calculated pseudorange
    % We assume that the PRN is simply the index of the PR value in the PR vector
    calculated_PRN(i) = find(PR == expected_PR, 1);
end

% Compare calculated PRN with provided PRN to find inconsistencies
inconsistent_PRN = find(calculated_PRN ~= SV.PRN);

% Display inconsistent PRN

disp(['Inconsistent PRN to be excluded: ', num2str(inconsistent_PRN)]);
