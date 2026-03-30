public abstract class Animal {
    public String name;
    public Animal(String name){
        this.name = name;
    }
    
    public virtual void sound() {
        System.debug(name +' Makes a sound');
    }
    
    public abstract void eats();
}