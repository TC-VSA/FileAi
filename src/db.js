const DB='nexus-file-explorer', VERSION=1;
const stores=['scanSessions','selectedRoots','fileRecords','errorLogs','renameSuggestions','auditEvents','userSettings'];
export function openDB(){return new Promise((res,rej)=>{const r=indexedDB.open(DB,VERSION);r.onupgradeneeded=()=>stores.forEach(s=>{if(!r.result.objectStoreNames.contains(s))r.result.createObjectStore(s,{keyPath:'id'})});r.onsuccess=()=>res(r.result);r.onerror=()=>rej(r.error)})}
export async function putMany(store,items){if(!items.length)return;const db=await openDB();await new Promise((res,rej)=>{const tx=db.transaction(store,'readwrite'),os=tx.objectStore(store);items.forEach(x=>os.put(x));tx.oncomplete=res;tx.onerror=()=>rej(tx.error)});db.close()}
export async function getAll(store){const db=await openDB();const out=await new Promise((res,rej)=>{const r=db.transaction(store).objectStore(store).getAll();r.onsuccess=()=>res(r.result);r.onerror=()=>rej(r.error)});db.close();return out}
export async function clearStore(store){const db=await openDB();await new Promise((res,rej)=>{const tx=db.transaction(store,'readwrite');tx.objectStore(store).clear();tx.oncomplete=res;tx.onerror=()=>rej(tx.error)});db.close()}
export {stores};
