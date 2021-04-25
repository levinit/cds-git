;schRegPostCheckTrigger('CGcheckTrigger)



load(strcat(cdsgit_path "/triggers/CGsaveTrigger.il"))
load(strcat(cdsgit_path "/triggers/CGpreDeleteTrigger.il"))
load(strcat(cdsgit_path "/triggers/CGpostCreateCvTrigger.il"))
load(strcat(cdsgit_path "/triggers/CGpostCopyTrigger.il"))

dbRegPostSaveTrigger('CGsaveTrigger)
ddRegTrigger("PreDeleteObj" 'CGpreDeleteTrigger)
ddRegTrigger("PostCreateObj" 'CGpostCreateCvTrigger)
ccpRegTrigger("ccpPostCopyTrigger" 'CGcopyTrigger nil)

