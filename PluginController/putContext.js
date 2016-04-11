var identifier = "context-" + NSDate.date();
NSThread.currentThread().threadDictionary().setObject_forKey_(context, identifier);
log(identifier);