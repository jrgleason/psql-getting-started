import showdown  from 'showdown';
import fs from 'fs';
import 'showdown-target-blank';
let targetblank = ()=>{
      return [
         {
            type:   'output',
            regex: '<a(.*?)>',
            replace: function (match, content) {
               return content.indexOf('mailto:') !== -1 ? '<a' + content + '>' : '<a target="_blank"' + content + '>';
            }
         }
      ];
   };
showdown.extension("targetblank", targetblank);   
const converter = new showdown.Converter({extensions: ['targetblank']});
let dirCont = fs.readdirSync( '../labs' );
let files = dirCont.filter( ( elm )=> elm.match(/.*\.(md)/ig))
                   .map((elm)=> `../labs/${elm}`);
files.forEach((filename)=>{
	fs.readFile(filename, "utf8", (err, data)=>{
	  let outputFile = filename.replace(/\.md/i, '.html');
	  fs.writeFile(outputFile, converter.makeHtml(data)); 
    });
})