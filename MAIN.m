function MAIN()

%% This repo has some code that automates databasing PFC radio code 

addBrainRadioVisit() % adds Brain Radio .JSON for each txt file  
addBrainRadioCondition() %add a condition to all .JSON for visits
updataDataBase() %updates database file to include all current .JSON's
printBrainRadioReport() % Use .JSON files to print a report of patients and visits  



end