function pos = boxFinder(im)
    threshold = 0.51;
    imBW = im;
    pos = [1,1,1,1];

    for i = 1:size(im,1);
        for j = 1:size(im,2);
            if im(i,j) < threshold
                imBW(i,j) = 0;
            else
                imBW(i,j) = 1;
            end
        end
    end
import matplotlib.pyplot as plt
from matplotlib.widgets import RectangleSelector

def annotate_gel_image(image_path):
    # Load the image
    img = plt.imread(image_path)

    # Define a function to annotate the selected region
    def onselect(eclick, erelease):
        global x1, y1, x2, y2
        x1, y1 = int(eclick.xdata), int(eclick.ydata)
        x2, y2 = int(erelease.xdata), int(erelease.ydata)
        print(f"Selected region: ({x1}, {y1}) to ({x2}, {y2})")

    # Define a function to save the selected region
    def onsave(event):
        global x1, y1, x2, y2
        selected_region = img[y1:y2, x1:x2]
        plt.imsave(f"annotated_{image_path}", selected_region, cmap='gray')
        print(f"Selected region saved as annotated_{image_path}")

    # Display the image and set up the rectangle selector
    fig, ax = plt.subplots()
    ax.imshow(img, cmap='gray')
    rs = RectangleSelector(ax, onselect, drawtype='box', useblit=True, button=[1], minspanx=5, minspany=5,
                           spancoords='pixels', interactive=True)
    fig.canvas.mpl_connect('key_press_event', onsave)
    plt.show()

# Example usage
annotate_gel_image("gel_image.png")

    for i = 1:size(im,1);
        for j = 1:size(im,2);
            width = 1;
            height = 1;
            xpos = j;
            ypos = i;
            while imBW(i,j) == 1 && i < size(im,1)
                i = i + 1;
                height = height + 1;
            end
            i = ypos;
            while imBW(i,j) == 1 && j < size(im,2)
                j = j + 1;
                width = width + 1;
            end
            if width * height > pos(3) * pos(4);
                pos = [ypos,xpos,height,width];
            end
        end
    end
end
