// --- TODO: Change stm32 family header file and board (optional)
#include "stm32f7xx.h"
#include "stm32f769i_discovery.h"

int main()
{

    HAL_Init();
    BSP_LED_On(LED_GREEN);

    while(1) {
        for (int i = 0; i < 1000000; i++);
        BSP_LED_Toggle(LED_RED);

    }

    return 0;
}
