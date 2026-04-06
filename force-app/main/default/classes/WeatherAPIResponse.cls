public  class WeatherAPIResponse {
    
    public Main main;
    public List<Weather> weather;
    public String name;
    
    public class Main {
        public Decimal temp;
        public Decimal humidity;
        public Decimal feels_like;
    }
    
    public class Weather {
        public String main;
        public String description;
    }
    
}