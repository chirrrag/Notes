> cdk synth
    this command will generate the cloud formation template, which we can use later
> cdk bootstrap
    this will actually run the script
    this will create the infrastructure, configure roles, policies and create the metadata as well
> cdk deploy
    to deploy the infra
> cdk destroy 
    to destroy the created infra

# commands
> cdk version
    to get the cdk version
> cdk init <TEMPLATE> --language <LANGUAGE>
    create new cdk project(app)
> cdk bootstrap
    bootstrap the AWS environment
    with bootstrap it is going to install the stack with some cdk resources that are needed to manage the stack within that environment.
> cdk list
    will give you list of all the stacks within the cdk application
    stacks are unit of deployment, so we will know what stacks we have to deploy, and what not
> cdk deploy --profile <profile>
    depkloy a cdk stack
> delete the stack
    cdk destroy
> cdk docs
    launch the cdk documentattion   
> cdk diff
    compares local and deployed stack
> cdk synth
    generates  the cloud formation templates

   # specify specific stack or multiple stakcs for the action
   > cdk deploy <STACK NAME> 
   > cdk deploy <STACK 1> <STACK 2>
   # for all stacks
   > cdk deploy "*"

> cdk doctor
    check your app forr problems

    10.0.0.219
    10.0.1.177