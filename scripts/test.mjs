import showdown  from 'showdown';
import fs from 'fs';
const converter = new showdown.Converter();
let dirCont = fs.readdirSync( '../labs' );
let files = dirCont.filter( ( elm )=> elm.match(/.*\.(md)/ig))
                   .map((elm)=> `../labs/${elm}`);
console.log(files);                   
files.forEach((filename)=>{
	fs.readFile(filename, "utf8", (err, data)=>{
	  let outputFile = filename.replace(/\.md/i, '.html');
	  fs.writeFile(outputFile, converter.makeHtml(data)); 
    });
})

// text      = '#hello, markdown!',
// html      = converter.makeHtml(text);