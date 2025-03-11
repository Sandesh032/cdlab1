#include <bits/stdc++.h>
using namespace std;
#define pb push_back

void removeLeftRecursion(map<string, vector<string>> &grammar) {
    map<string, vector<string>> newGrammar;

    for (auto &nonTerminal : grammar) {
        string A = nonTerminal.first;
        vector<string> productions = nonTerminal.second;

        vector<string> beta, alpha;
        for (string prod : productions) {
            if (prod[0] == A[0]) {
                alpha.push_back(prod.substr(1));
            } else {
                beta.push_back(prod);
            }
        }

        if (!alpha.empty()) {
            string A_prime = A + "'";
            for (string b : beta) newGrammar[A].pb(b + A_prime);
            for (string a : alpha) newGrammar[A_prime].pb(a + A_prime);
            newGrammar[A_prime].pb("ε");
        } else {
            newGrammar[A] = beta;
        }
    }

    for (auto &nonTerminal : newGrammar) {
        cout << nonTerminal.first << " -> ";
        for (string prod : nonTerminal.second)
            cout << prod << " | ";
        cout << endl;
    }
}

void leftFactoring(map<string, vector<string>> &grammar) {
    map<string, vector<string>> newGrammar;

    for (auto &nonTerminal : grammar) {
        string A = nonTerminal.first;
        vector<string> productions = nonTerminal.second;

        map<string, vector<string>> prefixMap;
        for (string prod : productions) {
            string prefix = prod.substr(0, 1);
            prefixMap[prefix].pb(prod.substr(1));
        }

        if (prefixMap.size() > 1) {
            string A_prime = A + "'";
            for (auto &prefix : prefixMap) {
                string prefixProd = prefix.first;
                newGrammar[A].pb(prefixProd + A_prime);
                for (string subProd : prefix.second)
                    newGrammar[A_prime].pb(subProd);
            }
        } else {
            newGrammar[A] = productions;
        }
    }

    for (auto &nonTerminal : newGrammar) {
        cout << nonTerminal.first << " -> ";
        for (string prod : nonTerminal.second)
            cout << prod << " | ";
        cout << endl;
    }
}

int main() {
    map<string, vector<string>> grammar;
    string inp, line, nonTerminal, prod;

    cout << "Enter grammar:" << endl;
    cout << "For each production non-terminal, enter its productions separated by '|'. e.g. S -> aSb | a" << endl;

    while (true) {
        cout << "Enter a non-terminal (or type 'end' to finish): ";
        getline(cin, nonTerminal);
        if (nonTerminal == "end") break;
        cout << "Enter productions for " << nonTerminal << ": ";
        getline(cin, inp);

        stringstream ss(inp);
        while (getline(ss, prod, '|'))
            grammar[nonTerminal].pb(prod);
    }

    cout << "\nOriginal Grammar" << endl;
    for (const auto &rule : grammar) {
        cout << rule.first << " -> ";
        for (const string &prod : rule.second)
            cout << prod << " | ";
        cout << endl;
    }

    cout << "\nGrammar after removing left recursion:" << endl;
    removeLeftRecursion(grammar);

    cout << "\nGrammar after left factoring:" << endl;
    leftFactoring(grammar);

    return 0;
}