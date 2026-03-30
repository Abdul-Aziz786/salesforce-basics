public class Dog extends Animal  {
    
    public Dog(){
        super('Dog');
    }
    
    public override void sound() {
        System.debug(name + 'is Barking');
    }
    
    public override void eats() {}
}