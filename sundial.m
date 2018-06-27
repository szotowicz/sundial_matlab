% Miko³aj Szotowicz, date: 26/11 
% Mecca in Saudi Arabia 21° 25' 36" N 39° 49' 34" E

clc;
precision = 0.001;
meccaX = 0.69509676521; % 39° 49' 34" E = 39.826111°
meccaY = 0.37396588688; % 21° 25' 36" N = 21.426667°
declination = -0.36372661612; % -20.84°, date: 26/11
hourpointsLabelsNum = [8, 7 , 6, 5, 4, 3, 2, 1, 12, 11, 10, 9, 8, 7, 6, 5, 4]'; 
hourpointsLabels = cellstr(num2str(hourpointsLabelsNum));
                  
fi = meccaX;
a = 4;
b = sin(fi) * a;

% Middle
M = [0 0];
% Focal length
F = [a * cos(fi) 0];

% Axes
X = [-a:precision:a];
Y = [-b:precision:b];

% Circumference of the ellipse
ellipseCircumference  = 0:precision:2*pi;
xCircumference = a * cos(ellipseCircumference);
yCircumference = b * sin(ellipseCircumference);

% Hourpoints
t = (-pi/6):(pi/12):(pi/6)+pi;
xHourpoints = a * cos(t);
yHourpoints = b * sin(t);

% Pin
pinY = a * cos(fi) * tan(declination);
pinX = 0;

Rcircle = (a * cos(fi))/(sin(2*declination));
Ycircle = (a * cos(fi))/(tan(2*declination));

% Circle of Lambert
tLambert = (pi/5.2):precision:pi-(pi/5.2);
xLambert = Rcircle * cos(tLambert);
yLambert = Rcircle * sin(tLambert) + abs(Ycircle);

% using http://www.wolframalpha.com
lambertPointX = sqrt(...
(-a^4 * b^2 * Rcircle^2 * Rcircle^2 - a^4 * (pinY + abs(Rcircle))^2 * Rcircle^2 * Rcircle^2 + a^4 * Rcircle^2 * Rcircle^4 + ...
a^2 * b^4 * Rcircle^4 - a^2 * b^2 * (pinY + abs(Rcircle))^2 * Rcircle^4 - a^2 * b^2 * Rcircle^4 * Rcircle^2 + 2 *...
sqrt(a^4 * b^2 * (pinY + abs(Rcircle))^2 * Rcircle^4 * Rcircle^2 *...
(a^4 * Rcircle^2 - a^2 * b^2 * Rcircle^2 + a^2 * (pinY + abs(Rcircle))^2 * Rcircle^2 - a^2 * Rcircle^2 * Rcircle^2 + b^2 * Rcircle^4))...
)/(b^2 * Rcircle^2 - a^2 * Rcircle^2)^2);

lambertPointY = abs(sqrt(Rcircle^2 - lambertPointX^2) - (pinY + abs(Rcircle)));


% Draw sundial
plot([X(1) X(end)], M, M, [Y(1) Y(end)], ...  % Axes
      F(1), F(2), 'b*', -F(1), F(2), 'b*', ...  % Focal lengths
      xHourpoints, yHourpoints, 'k*', ...
      0, pinY + abs(Rcircle), 'r*', ...
      pinX, pinY, 'r*', ...                     % Pin
      lambertPointX, lambertPointY, 'r*', ...
      -lambertPointX, lambertPointY, 'r*', ...
      xLambert, yLambert, ...                   % Circle of Lambert
      xCircumference, yCircumference)           % Circumference
 
% Add hours label 
text((a+0.6)*cos(t)-0.2, (b+0.6)*sin(t), hourpointsLabels)
  
disp('Press a key !') % Press any key
pause;
pause(1) 

% Animation + remove unnecessary elements
for i=14:-1:4
  plot(...
      ...% [X(1) X(end)], M, M, [Y(1) Y(end)], ...  % Axes
      ...% F(1), F(2), 'b*', -F(1), F(2), 'b*', ...  % Focal lengths
      xHourpoints, yHourpoints, 'k*', ...
      ...% 0, pinY + abs(Rcircle), 'r*', ...       
      pinX, pinY, 'r*', ...                     % Pin
      lambertPointX, lambertPointY, 'r*', ...
      -lambertPointX, lambertPointY, 'r*', ...
      ...% xLambert, yLambert, ...                   % Circle of Lambert
      [pinX xHourpoints(i)] ,[pinY yHourpoints(i)],...% Animation
      xCircumference, yCircumference)           % Circumference

  % Add hours label 
  text((a+0.6)*cos(t)-0.2, (b+0.6)*sin(t), hourpointsLabels)
  
  pause(.5)
end