#!/bin/bash

echo "Bienvenido humanoide"

API_KEY="a95772c55ce5485b8ed212209242106"  
CIUDAD="Bahia Blanca, Buenos Aires, Argentina"

URL="http://api.weatherapi.com/v1/current.json?key=$API_KEY&q=$CIUDAD&lang={es}"

curl -s $URL > respuesta.json

echo "El clima actual en | $CIUDAD | es:"
echo "---------------------------------------"
echo "Temperatura: $(jq -r '.current.temp_c' respuesta.json) grados Celsius"
echo "Condicion: $(jq -r '.current.condition.text' respuesta.json)"
echo "Humedad: $(jq -r '.current.humidity' respuesta.json)%"
echo "Velocidad del viento: $(jq -r '.current.wind_kph' respuesta.json) km/h"
echo "---------------------------------------"


rm respuesta.json
