const AWS = require('aws-sdk');
const moment = require('moment');

AWS.config.update({ region: 'us-east-1' }); // Replace 'your-region' with your AWS region

const s3 = new AWS.S3();

const bucketName = 'mys3bucket-149'; // Replace 'your-bucket-name' with your S3 bucket name

const sixMonthsAgo = moment().subtract(6, 'months');

const params = {
  Bucket: bucketName,
};

s3.listObjectsV2(params, (err, data) => {
  if (err) {
    console.error('Error listing objects:', err);
    return;
  }

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
    Delete: {
      Objects: objectsToDelete.map((obj) => ({ Key: obj.Key })),
    },
  };

  s3.deleteObjects(deleteParams, (deleteErr, deleteData) => {
    if (deleteErr) {
      console.error('Error deleting objects:', deleteErr);
    } else {
      console.log(`Deleted ${deleteData.Deleted.length} objects.`);
    }
  });
});