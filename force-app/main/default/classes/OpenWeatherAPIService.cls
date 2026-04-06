public with sharing class OpenWeatherAPIService {
    @future(callout=true)
    public static void fetchWeather(Id cityId,String cityName) {
        updateWeather(cityId, cityName);
    }
    
    public static void updateWeather(Id cityId, String cityName) {
        Http htp = new Http();
        HttpRequest req = new HttpRequest();
        Weather_Config__mdt config = Weather_Config__mdt.getInstance('Default');
        req.setMethod('GET');
        req.setEndpoint('Callout:OpenWeatherAPI/data/2.5/weather?q=' + cityName + '&appid=' + config.API_Key__c + '&units=metric');
        try {
            HttpResponse res = htp.send(req);
            if (res.getStatusCode() == 200) {
                WeatherAPIResponse weatherResponse = (WeatherAPIResponse) JSON.deserialize(res.getBody(), WeatherAPIResponse.class);
                City__c city = new City__c(Id = cityId);
                city.Temperature__c = weatherResponse.main.temp;
                city.Humidity__c = weatherResponse.main.humidity;
                city.Weather_Description__c = weatherResponse.weather[0].description;
                update city;
            } else {
                System.debug('Error fetching weather data: ' + res.getStatusCode() + ' - ' + res.getBody());
            }
        } catch (Exception e) {
            System.debug('Exception occurred: ' + e.getMessage());
        }
    }
    
    
    
}