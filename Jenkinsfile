// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//
// Jenkinsfile defining a mini pipeline to build and stage a Docker image
// containing the following:
//    NodeJS in the desired version
//    Yarn
//    Puppet Agent
//    Nagios NRPE server
//
// Author
//     Peter L. Berghold <pberghold@tenna.com>
//
// Copyright and License
//
//     This work is copyrighted (c) Copyright 2019, Tenna LLC all rights
//     reserved.
//
//     No derived works from this should be made without consulting the
//     author or a representative of Tenna LLC and without express permission.
//
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
node("master"){
  parameters {[
     string (
      name: 'BuildEnv',
      default: 'QA',
      description: 'any'
   ),
   choice(
     name: 'NodeJSVersion',
     choices: '11\n10\n8',
     description: 'Which NodeJS do we want in the container?'
   ),
   string (
     name: 'ImageVersionTag',
     default: '0.5.0',
     description:  'Which version to tag this with (e.g. image:${version}'
   )
   
  ] }
  def String giturl = "git@github.com:ten-peb/docker-ubuntu-nodejs.git"
  def String clone2 = 'tenna-nodejs'
  def String image_base_tag = "tenna/nodejs" 
  def String image_version_tag = "${params.ImageVersionTag}"

  // Grab the latest version from GitHub to "clone2" subdirectory to work on
  stage("checkout source"){
    doGitClone(giturl,clone2)
  }
  // Build the image
  stage("build image"){
    String[] args = ["NodeJSVersion=${parms.NodeJSVersion}"]
    dir(clone2){
      def String image_tag = image_base_tag + ':' + image_version_tag;
      doDockerBuildArgs(image_tag,args)
          
      doDockerBuild(image_base_tag + ':latest')
            )
    }		 
  }
  // Brag about it.
  stage("Send Notification of Success"){
    def String[] message = [
    "Greetings,",
    "This is to inform you that the Docker image ${image_base_tag} version ${image_version_tag}",
    "This image contains NodeJS (version ${params.NodeJSVersion}) and",
    "the Puppet agent and Nagios NRPE server",
    "Was successfully built and pushed to the registry.",
    " ",
    "Sincerely,",
    "Your faithful servant."," Jenkins"
    ]
    sendEmail(qaTeam(),"ubuntu-nodejs-11 built",message.join("\n"))
  }
}