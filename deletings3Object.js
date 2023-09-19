const AWS = require('aws-sdk');
const moment = require('moment');

// aws programtic 

const accesskey = "AKIA2DRMGJ5Q5UOVT6OT"
const scerectkey = "aDmQT1uk76/tKSksFoCdyJtS86pwhL91TOikZhHr"

// set AWS_ACCESS_KEY_ID=AKIA2DRMGJ5Q5UOVT6OT
// set AWS_SECRET_ACCESS_KEY=aDmQT1uk76/tKSksFoCdyJtS86pwhL91TOikZhHr
// set AWS_DEFAULT_REGION=us-east-1

AWS.config.update({ region: 'us-east-1', }); // Replace 'your-region' with your AWS region

const s3 = new AWS.S3({});

const bucketName = 'awsbucket-14'; // Replace 'your-bucket-name' with your S3 bucket name

const sixMonthsAgo = moment().subtract(1, 'days');

const params = {
    Bucket: bucketName,
};

s3.listObjectsV2(params, (err, data) => {
    if (err) {
        console.error('Error listing objects:', err);
        return;
    }

   // console.log(data)

    const objectsToDelete = data.Contents.filter((obj) => {
        const objectLastModified = moment(obj.LastModified);
        return objectLastModified.isBefore(sixMonthsAgo);
    });

    if (objectsToDelete.length === 0) {
        console.log('No objects found older than 6 months.');
        return;
    }

    const deleteParams = {
        Bucket: bucketName,
        Delete: { Objects: objectsToDelete.map((obj) => ({ Key: obj.Key })), },
    };

    console.log(deleteParams);

    s3.deleteObjects(deleteParams, (deleteErr, deleteData) => {
        if (deleteErr) {
            console.error('Error deleting objects:', deleteErr);
        } else {
            console.log(`Deleted ${deleteData.Deleted.length} objects.`);
        }
    });
});

