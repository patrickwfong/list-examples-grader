CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

rm -rf student-submission
rm -rf grading-area

mkdir grading-area

git clone $1 student-submission
echo 'Finished cloning'


# Draw a picture/take notes on the directory structure that's set up after
# getting to this point

# Then, add here code to compile and run, and do any post-processing of the
# tests

if ! [[ -f student-submission/ListExamples.java ]]; then
echo 'Could not find ListExamples.java in the submitted directory.'
exit
fi

cp *.java grading-area
cp student-submission/*.java grading-area
cp -r lib grading-area

cd grading-area

javac -cp $CPATH Server.java GradeServer.java ListExamples.java TestListExamples.java
if [[ $? -ne 0 ]]; then
javac -cp $CPATH Server.java GradeServer.java ListExamples.java TestListExamples.java 2> CompileError.txt
echo 'Did not compile, see CompileError.txt for more info'
exit
fi

java -cp $CPATH org.junit.runner.JUnitCore TestListExamples > TestListExamplesOutput.txt
echo 'All tests ran, check TestListExamplesOutput.txt for results'