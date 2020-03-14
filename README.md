# PI Day 2020 - a visualization
## A simple yet fascinating way of visualizing the first million digits of PI

Visualizing the first million digits of PI in a colorful (and round) way, in honor of the 2020 PI day.  
This script will generate an image like this:

![PI visualization](https://github.com/lorossi/pi-day-2020-visualization/blob/master/rendered/pi-title-1000px_rescaled.png)  

Each arc connects two consecutives digits of PI. The color and the starting position of the arc is set by the first digit and the arc lands in the region of the second digit. If the first digit is bigger than the second, the arc will be drawn on the higher half of the image. Otherwise, it will be drawn on the lower one.  
After one million of digits, this is what the script renders.

The script can be tweaked in multiple way to get a different output (for example, the size of the output image and the number of digits visualized can be changed). Currently, it generates a 10000 pixels by 10000 pixels PNG image using 1 million of pi digits (found in the _pi.txt_ file inside the _data_ folder).  
You can run the program by yourself (mind that it will be quite slow) or view the full-size image in the _rendered_ folder (very big, about 63MB). In the same same folder there's also a _rescaled_ 1000 pixels by 1000 pixels image.

## Credits
The font used is [_Roboto_ by _Christian Robertson_.](https://github.com/google/roboto/)

The pi.txt file was sourced on [_piday.org_](https://www.piday.org/million/)
