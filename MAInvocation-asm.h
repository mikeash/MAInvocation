
struct RawArguments
{
    void *fptr;
    
    uint64_t rdi;
    uint64_t rsi;
    uint64_t rdx;
    uint64_t rcx;
    uint64_t r8;
    uint64_t r9;
    
    uint64_t stackArgsCount;
    uint64_t *stackArgs;
    
    uint64_t rax;
};

void MAInvocationCall(struct RawArguments *);
