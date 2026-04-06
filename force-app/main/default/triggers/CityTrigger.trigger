trigger CityTrigger on City__c (after insert) {
    for (City__c city : Trigger.new) {
        System.debug('New city inserted: ' + city.Name);
        OpenWeatherAPIService.fetchWeather(city.Id, city.Name);
    }
}