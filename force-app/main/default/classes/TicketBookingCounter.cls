// 2. Ticket Booking Counter
public class TicketBookingCounter {
    
    public static Integer ticketsBooked = 0;
    
    public static void bookTicket(Integer count) {
        ticketsBooked += count;
        System.debug('bookTicket(' + count + ') → Tickets Booked So Far: ' + ticketsBooked);
    }
}