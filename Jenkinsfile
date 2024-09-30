pipeline {
  agent any
  environment {
    S3_BUCKET = 'my-app-pipeline-artifacts'
    AWS_REGION = 'us-west-2'
  }
  stages {
    stage('Build') {
      steps {
        echo 'Building the application...'
        sh 'npm install'
        sh 'npm run build'
      }
    }
    stage('Test') {
      steps {
        echo 'Running tests...'
        sh 'npm test'
      }
    }
    stage('Package') {
      steps {
        echo 'Packaging the application...'
        sh 'zip -r build.zip .'
        archiveArtifacts artifacts: 'build.zip'
      }
    }
    stage('Upload to S3') {
      steps {
        echo 'Uploading build.zip to S3...'
        sh 'aws s3 cp build.zip s3://$S3_BUCKET/'
      }
    }
    stage('Deploy') {
      steps {
        echo 'Deploying to Elastic Beanstalk...'
        sh 'aws elasticbeanstalk create-application-version --application-name my-app --version-label v1 --source-bundle S3Bucket=$S3_BUCKET,S3Key=build.zip'
        sh 'aws elasticbeanstalk update-environment --application-name my-app --environment-name my-app-env --version-label v1'
      }
    }
  }
}
