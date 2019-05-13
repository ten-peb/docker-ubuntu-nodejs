node("master"){
  parameters {
    string (
      name: 'BuildEnv',
      default: 'QA',
      description: 'any'
   )
  }
  def String giturl = "git@github.com:ten-peb/docker-ubuntu-nodejs.git"
  def String clone2 = 'docker-ubuntu-nodejs'
  def String image_base_tag = "ubuntu-nodejs-11"
  def String image_version_tag = "0.5.5" 
  stage("checkout source"){
    // checkout the master branch of the image repo 
    doGitClone(giturl,clone2)
  }
  stage("build image"){
    dir(clone2){
      def String image_tag = image_base_tag + ':' + image_version_tag;
      doDockerBuild(image_tag)
      doDockerBuild(image_base_tag + ':latest')
    }		 
  }
  stage("Send Notification of Success"){
    def String[] message = [
    "Greetings,",
    "This is to inform you that the Docker image ubuntu-nodejs-11",
    "Was successfully built and pushed to the registry.",
    " ",
    "Sincerely,",
    "Your faithful servant Jenkins"
    ]
    sendEmail(qaTeam(),"ubuntu-nodejs-11 built",message.join("\n"))
  }
}