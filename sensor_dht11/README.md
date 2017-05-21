# DHT11 Sensor reading experiment

Using python library from https://github.com/szazo/DHT11_Python

There are two files, both read the DHT11 sensor on a specific pin. You can run them with command:

python read.py <pin>
python read2.py <pin>

## read.py

Using python DHT11 library from https://github.com/szazo/DHT11_Python.

## read2.py

Using Adafruit DHT11 library described in this article: http://www.circuitbasics.com/how-to-set-up-the-dht11-humidity-sensor-on-the-raspberry-pi/

To install you need to install the library first:

1. Enter this at the command prompt to download the library:

git clone https://github.com/adafruit/Adafruit_Python_DHT.git

2. Change directories with:

cd Adafruit_Python_DHT

3. Now enter this:

sudo apt-get install build-essential python-dev

4. Then install the library with:

sudo python setup.py install