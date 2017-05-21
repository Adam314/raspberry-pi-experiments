#!/usr/bin/python
import sys
import Adafruit_DHT

pin = int(sys.argv[1])

while True:

    humidity, temperature = Adafruit_DHT.read_retry(11, pin)
    
    print 'Temp: {0:0.1f} C  Humidity: {1:0.1f} %'.format(temperature, humidity)