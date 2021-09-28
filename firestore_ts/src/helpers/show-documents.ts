import firebase from "firebase";

export const returnDocuments = ( snapshot:firebase.firestore.QuerySnapshot ) => {
  const users: any[] = [];
  snapshot.forEach( (childSnap) => {
    users.push({
      id: childSnap.id,
      ...childSnap.data()
    });    
  });

  console.log(users);
  
}