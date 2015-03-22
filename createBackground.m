ah = axes('unit', 'normalized', 'position', [0 0 1 1], 'Parent', hObject);
bg = imread('images/backgroundLeftPanel.jpg'); imagesc(bg);
set(ah, 'handlevisibility', 'off', 'visible', 'off');
uistack(ah, 'bottom');