#include<bits/stdc++.h>
#define ll long long int
using namespace std;
int main(){
ll i,t,n;
string s;
cin>>t;
while(t--){
        n=0;
    getline(cin,s);
    for(i=s.begin;i<s.end;i++){
        if(s[i]==' ' && s[i+1]=='n' && s[i+2]=='o' && s[i+3]=='t'){
                if(s[i+4]=='\0' || s[i+4]==' '){
            n=1;
            break;
        }
        }
    }
        if(n==1)
            cout<<"Real Fancy"<<"\n";
        else
            cout<<"regularly fancy"<<"\n";
    }

return 0;


}
