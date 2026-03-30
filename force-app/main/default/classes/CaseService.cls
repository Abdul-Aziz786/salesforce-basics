public  class CaseService {
    public static List<Case> getCasesCreatedInLast3Days() {
        return [
			SELECT Id, CaseNumber, Subject, CreatedDate
			FROM Case
			WHERE CreatedDate = LAST_N_DAYS:3
			ORDER BY CreatedDate DESC
		];
    }
}