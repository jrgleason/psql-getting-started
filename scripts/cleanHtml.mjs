import fs from 'fs';
let files = dirCont.filter( ( elm )=> elm.match(/.*\.(html)/ig))
                   .map((elm)=> `../labs/${elm}`);
files.forEach((filename)=>{
  // TODO: Delete file
})                   