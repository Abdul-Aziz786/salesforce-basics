@IsTest
private class StudentutilityTest {
    @IsTest
    static void testCalculateGrade() {
        Assert.areEqual('A', Studentutility.calculateGrade(90, 95, 92));
        Assert.areEqual('B', Studentutility.calculateGrade(75, 80, 78));
        Assert.areEqual('C', Studentutility.calculateGrade(60, 62, 65));
        Assert.areEqual('D', Studentutility.calculateGrade(40, 45, 42));
        Assert.areEqual('F', Studentutility.calculateGrade(20, 30, 35));
    }
    
    @IsTest
    static void testCalculateGradeNullMarks() {
        Assert.areEqual('No Grade', Studentutility.calculateGrade(null, 80, 70));
        Assert.areEqual('No Grade', Studentutility.calculateGrade(80, null, 70));
        Assert.areEqual('No Grade', Studentutility.calculateGrade(80, 70, null));
    }
}