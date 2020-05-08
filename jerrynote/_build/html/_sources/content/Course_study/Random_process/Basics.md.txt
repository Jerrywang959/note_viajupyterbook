概率空间

$\Omega$：样本空间

事件、样本点$\omega \in \Omega$

$\Omega=\{\omega_1,\omega_2\}$

1. 无序
2. 可数或者不可数

$\omega\in A\subseteq\Omega$



定义1.1

我们称$\Omega$为抽象空间

定义1.2

如果 $\mathscr{F}$是$\omega$的子集组成的集合，且满足

1. $\empty\in\mathscr{F}$
2. 若$A\in\mathscr{F}$，则$A^c\in\mathscr{F}$
3. 若$A_1,...A_n\in\mathscr{F}，则\cup_{i=1}^nA_i\in\mathscr{F}$

那么，我们称$\mathscr{F}为\omega的\sigma域，或称\sigma代数$







定义1.3 

概率测度$P$

若$(\Omega,\mathscr{F})$为可测空间，定义集函数$P:\mathscr{F} \rightarrow [0,1]$，且满足

1. $P(\empty)=0$
2. $P(\Omega)=1$
3. $ \forall A_1,A_2,...A_n \in \mathscr{F}, \mathrm{and} \  A_i\cap A_j=\empty ,\quad P(\cup_{k=1}^{\infin} A_k)=\sum_{k=1}^\infin P(A_k) $

则我们称$P$为$(\Omega,\mathscr{F})$上的概率测度





性质1.4

若$P$为$(\Omega,\mathscr{F})$上的概率测度，则有

1. $P(\empty)=0,P(\Omega)=1$
2. 若$A\in \mathscr{F},P(A^c)=1-P(A)$
3. 若$A,B\in\mathscr{F},P(A\cup B)=P(A)+P(B)$
4. 若$A_1,...A_n \in \mathscr{F}，$且$A_i\cap A_j=\empty (i\not =j)$，则$P(\cup_{k=1}^nA_k)=\sum_{k=1}^nP(A_k)$（有限可加）





定义1.7

若$\{A_1,...,A_n,...\}$满足

1. $A_n\subseteq A_{n+1}$，称$\{A_n,n\geq 1\}$为递增集合序列
2. $A_n\supseteq A_{n+1}$，称$\{A_n,n\geq 1\}$为递减集合序列



定义1.8

若$\{A_n,n\geq 1\}$，是递增集合序列，$\lim\limits_{n\rightarrow \infin}=\cup_{k=1}^\infin A_k$

若$\{A_n,n\geq 1\}$，是递减集合序列，$\lim\limits_{n\rightarrow \infin}=\cap_{k=1}^\infin A_k$



定理

若$\{A_n,n\geq1\}\in\mathscr{F},\mathscr{F}为\sigma$域，$\{A_n,n\geq1\}$是单调增（减）集合序列，则$\lim\limits_{n\rightarrow \infin}P(A_n)=P(\lim\limits_{n\rightarrow\infin}A_n)$





定义1.10

上极限：$\lim\sup A_n=\cap_n^\infin\cup_n^\infin A_n$
$$
\forall \omega \in \lim\sup A_n \Leftrightarrow \{ \omega:属于无穷多个 A_n \}  \\
\omega\in\cap_{n=1}^\infin\cup_n^\infin A_k \Leftrightarrow  \forall n\geq 1,\exists k\geq n，有 \omega \in A_k
$$



下极限：$\lim\sup A_n=\cap_n^\infin\cup_n^\infin A_n$

$$
\forall \omega \in \lim\inf A_n \Leftrightarrow \exists n\geq 1, \forall k\geq n,\omega\in A_k成立
$$


