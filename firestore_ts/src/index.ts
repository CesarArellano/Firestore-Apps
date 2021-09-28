import db from './firestore/config';
import { returnDocuments } from './helpers/show-documents';

// CREATE TABLE users; 
// Only send objects 
const user = {
  name: 'Jaqueline',
  active: false,
  birthday: '23-09-1999'
}

const usersRef = db.collection('users');

// INSERT INTO users ...
// db.collection('users')
//   .add( user )
//   .then( docRef => {
//     console.log(docRef);
//   })
//   .catch( e => console.log('error', e));

// UPDATE users SET active = true

// usersRef
//   .doc('b8BaC4kO0A237gm8WEN5')
//   .update({
//     active: false
//   });

// .set() this method is destructive
// usersRef
//   .doc('b8BaC4kO0A237gm8WEN5')
//   .update({ // Only update what you indicate, the rest remains
//     active: false
//   });


// DELETE FROM users WHERE id = 'xx';
// usersRef
// .doc('b8BaC4kO0A237gm8WEN5')
// .delete()
// .then( () => console.log('Borrado'))
// .catch( e => console.log('Error', e));

// SELECT * FROM users;

// It has observables 
// usersRef.onSnapshot( returnDocuments );

usersRef.get().then( returnDocuments );

// SELECT * FROM users WHERE active = true;
usersRef.where('active', '==', true).get().then( returnDocuments );

// SELECT * FROM users WHERE salary BETWEEN 15000 AND 23000;
usersRef.where('salary', '>=', 15000)
  .where('salary', '<=', 23000)
  .get().then( returnDocuments );

// SELECT * FROM users WHERE salary > 15000 AND active == true;
// Must make composite index from firebase
usersRef.where('salary', '>', 15000)
  .where('active', '==', true)
  .get().then( returnDocuments );


// ORDER BY Exclude those documents that do not contain this attribute / key
usersRef
  .orderBy('name')
  .orderBy('salary', 'desc')
  .get().then( returnDocuments );

  // LIMIT and Pagination
const btnPrevious = document.createElement('button');

btnPrevious.innerText = 'Previous Page';
document.body.append(btnPrevious);

let lastDocument: any = null;
let firstDocument: any = null;

btnPrevious.addEventListener('click', () => {
  const query = usersRef
    .orderBy('name')
    .endBefore( firstDocument );

  query.limit(2).get().then( snap => {
    firstDocument = snap.docs[0] || null;
    lastDocument = snap.docs[ snap.docs.length - 1 ] || null;
    returnDocuments(snap);
  });
  
});

const btnNext = document.createElement('button');

btnNext.innerText = 'Next Page';
document.body.append(btnNext);

btnNext.addEventListener('click', () => {
  const query = usersRef
    .orderBy('name')
    .startAfter( lastDocument );

  query.limit(2).get().then( snap => {
    lastDocument = snap.docs[ snap.docs.length - 1 ] || null;
    returnDocuments(snap);
  });
  
});