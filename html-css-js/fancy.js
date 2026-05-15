// This "Fancy" file will only work correctly if it is served via `npm run dev`
// because vite needs to resolve lib/main.js... I think... need to test...

import MyClass from './lib/main.js'

const myClass = new MyClass();

console.log(myClass.talk());
