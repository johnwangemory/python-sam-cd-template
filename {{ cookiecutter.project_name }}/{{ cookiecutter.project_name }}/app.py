
def lambda_handler(event):
    message = 'Hello {} {}!'.format(event['obj_name'], 
                                    event['body'])  
    return { 
        'message' : message
    }  
    