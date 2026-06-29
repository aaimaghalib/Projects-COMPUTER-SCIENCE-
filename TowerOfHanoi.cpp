#include <iostream>

void towerOfHanoi(int n, char source, char auxiliary, char destination) {
    if (n == 1) {
        std::cout << "Move disk 1 from " << source << " to " << destination << std::endl;
        return;
    }
    
    towerOfHanoi(n - 1, source, destination, auxiliary);
    std::cout << "Move disk " << n << " from " << source << " to " << destination << std::endl;
    towerOfHanoi(n - 1, auxiliary, source, destination);
}

int main() {
    int numDisks;
    
    std::cout << "Enter the number of disks: ";
    std::cin >> numDisks;
    
    std::cout << "Tower of Hanoi solution:" << std::endl;
    towerOfHanoi(numDisks, 'A', 'B', 'C');
    
    return 0;
}

