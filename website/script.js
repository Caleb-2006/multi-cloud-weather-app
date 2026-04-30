async function getWeather() {
    const city = document.getElementById('city').value;
    const apiKey = '9f965a03a960806551c565666e20690e';
    const url = `https://api.openweathermap.org/data/2.5/weather?q=${city}&appid=${apiKey}&units=metric`;
    
    const response = await fetch(url);
    const data = await response.json();
    
    if(data.cod === 200){
        document.getElementById('result').innerHTML = `
            <p>City: ${data.name}</p>
            <p>Temperature: ${data.main.temp}°C</p>
            <p>Weather: ${data.weather[0].description}</p>
        `;
    } else {
        document.getElementById('result').innerHTML = `<p>City not found</p>`;
    }
}