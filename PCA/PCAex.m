% Generate synthetic point cloud
x = 1 + 10.*randn(100,1);
y = 1 + 2.*randn(100,1);
xc = x - mean(x);
yc = y - mean(y);

X = [xc yc];
[coeff,score,latent] = pca(X);


% Plot first direction
figure(1)
clf;
scatter(xc,yc,'filled','MarkerFaceAlpha',.8)
hold on

quiver( 0, 0, 6*coeff(1,1), 6*coeff(1,2),"Color","r");
latexText = '$$v_1$$'; 
text(6*coeff(1,1), 6*coeff(1,2), latexText, 'Interpreter', 'latex', 'FontSize', 16, 'Color', 'black');

quiver( 0, 0, 6*coeff(2,1), 6*coeff(2,2),"Color","r");
latexText = '$$v_2$$';    
text(6*coeff(2,1), 6*coeff(2,2), latexText, 'Interpreter', 'latex', 'FontSize', 16, 'Color', 'black');
xlim([-30 30])
ylim([-15 15]) 
daspect([1 1 1])
set(gca, 'XTickLabel', []);
set(gca, 'YTickLabel', []);
set(gca, 'XTick', []);
set(gca, 'YTick', []);
box on
ax = gca;
ax.BoxStyle = 'full';

% Plot first component
figure(2)
clf;
comp1 = score(:,1)*coeff(1,:);
scatter(comp1(:,1),comp1(:,2),'filled','MarkerFaceAlpha',.8)
hold on

x1 = linspace(-30,30,100);
y1 = x1 * coeff(1,2) / coeff(1,1);

plot(x1,y1,"--", "Color",'black')

%scatter(X(:,1),X(:,2));
xlim([-30 30])
ylim([-15 15]) 
daspect([1 1 1])
set(gca, 'XTickLabel', []);
set(gca, 'YTickLabel', []);
set(gca, 'XTick', []);
set(gca, 'YTick', []);
box on
ax = gca;
ax.BoxStyle = 'full';

% Plot second component
figure(3)
clf;
comp2 = score(:,2)*coeff(2,:);
scatter(comp2(:,1),comp2(:,2),'filled','MarkerFaceAlpha',.8)
hold on

y2 = x1 * coeff(2,2) / coeff(2,1);

plot(x1,y2,"--", "Color",'black')


xlim([-30 30])
ylim([-15 15]) 
daspect([1 1 1])
set(gca, 'XTickLabel', []);
set(gca, 'YTickLabel', []);
set(gca, 'XTick', []);
set(gca, 'YTick', []);
box on
ax = gca;
ax.BoxStyle = 'full';
