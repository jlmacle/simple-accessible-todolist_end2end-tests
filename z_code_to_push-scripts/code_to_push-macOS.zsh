#-----------------------------------------------------------------------------------------------------------------------------
#  Making sure to have the default network configuration
#-----------------------------------------------------------------------------------------------------------------------------
echo "** Running ConfigurationUtility **"
#java -cp ../AccessibleTodoList_End2endTests/target/test-classes;../../../.m2/repository/org/slf4j/jcl-over-slf4j/1.7.30/jcl-over-slf4j-1.7.30.jar;../../../.m2/repository/org/slf4j/jul-to-slf4j/1.7.30/jul-to-slf4j-1.7.30.jar;../../../.m2/repository/org/slf4j/slf4j-api/1.7.13/slf4j-api-1.7.13.jar;../AccessibleTodoList_End2endTests/tmp/StringExternalization.java.txt jl.project.ConfigurationUtility "..\tmp" "\..\src\test\java\jl\project\" 

# ** Running the code quality **
echo ""
echo "** Starting SonarQube and running the code quality analysis **"


# Starting the SonarQube server
# The following code works. I have an issue when running sonar.sh.
osascript -e 'tell application "Terminal" to do script "sonar.sh start"'	
#osascript -e 'tell application "Terminal" to do script "echo \"Time to start the Sonarqube server\"" '	

# Running the analysis
# Waiting for the SonarQube server to start
echo "Waiting for the SonarQube server to start"
sleep 90

osascript -e 'tell application "Terminal" to do script "cd Desktop/AccessibleTodoList_End2endTests/ && mvn sonar:sonar -Dsonar.projectKey=End-to-endTesting:jl.project -Dsonar.host.url=http://localhost:9000 -Dsonar.login=$SONARQUBE_E2E"'

# Starting a browser to check the result of the analysis
echo "Waiting for the analysis to be done."
sleep 40 
echo ""
echo "Starting a browser to check the result of the analysis."
open -a Safari http://localhost:9000



#-----------------------------------------------------------------------------------------------------------------------------
#  Reducing the risk of credential leak.
#-----------------------------------------------------------------------------------------------------------------------------
echo ""
echo "** Running mvn clean ** "
echo "The value of an apiKey stored in an environment variable has been dumped and later pushed on GitHub."
echo "The dump file was in the surefire-reports folder. "
echo "mvn clean suppresses some data, including the surefire-reports. "

osascript -e 'tell application "Terminal" to do script "cd Desktop/AccessibleTodoList_End2endTests/ && mvn clean"'

echo "Waiting for the mvn clean to be done."
sleep 30


#-----------------------------------------------------------------------------------------------------------------------------
#  Pushing the code to Git
#-----------------------------------------------------------------------------------------------------------------------------
export commit_prefix="Work on the script used before pushing the code (macOS)."
export quotation_mark="\""
echo "git add ."
git add .
echo "Enter the message to append to: $commit_prefix " 
read commit_end
git "commit -m $quotation_mark $commit_prefix $commit_end $quotation_mark"
echo "git push"
git push
echo Commited and pushed  $quotation_mark  $commit_prefix $commit_end  $quotation_mark




