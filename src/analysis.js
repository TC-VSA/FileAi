const reserved=/^(con|prn|aux|nul|com[1-9]|lpt[1-9])(?:\.|$)/i;
export function analyzeName(name,deviceSuffixes=['-Uday’s MacBook Air']){const issues=[];let suggestion=name;
 if(/^\s|\s$/.test(name)){issues.push('Leading or trailing spaces');suggestion=suggestion.trim()}
 if(/\s{2,}/.test(name)){issues.push('Multiple spaces');suggestion=suggestion.replace(/\s{2,}/g,' ')}
 if(/_{2,}/.test(name)){issues.push('Multiple underscores');suggestion=suggestion.replace(/_{2,}/g,'_')}
 if(/\bCopy(?: \(\d+\))?(?=\.|$)/i.test(name)){issues.push('Copy suffix');suggestion=suggestion.replace(/\s*Copy(?: \(\d+\))?(?=\.|$)/i,'')}
 for(const suffix of deviceSuffixes){if(suggestion.includes(suffix)){issues.push('Device suffix');suggestion=suggestion.replace(suffix,'')}}
 if(reserved.test(name))issues.push('Reserved Windows name');
 if(/[<>:"/\\|?*]/.test(name))issues.push('Invalid Windows character');
 if(name.length>180)issues.push('Long filename');
 return {issues,suggestion,confidence:issues.length?'High':'Low',risk:reserved.test(name)||/[<>:"/\\|?*]/.test(name)?'Blocked':'Low'}
}
export function safeCsv(value){const s=String(value??'').replaceAll('"','""');return `"${/^[=+\-@]/.test(s)?"'"+s:s}"`}
export function formatBytes(n){if(!Number.isFinite(n))return '—';const u=['B','KB','MB','GB','TB'];let i=0;while(n>=1024&&i<u.length-1){n/=1024;i++}return `${n.toFixed(i?1:0)} ${u[i]}`}
export function extension(name){const i=name.lastIndexOf('.');return i>0?name.slice(i+1).toLowerCase():''}
