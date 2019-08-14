# memmory_block_vhdl

Блок памяти для взаимодействия с абстрактным вычислителем по средствам 4-ех паралельных синхронных интерфесов. Разрядность слова 8 бит. Для предотвращения коллизий с опирацией «запись» по одному адресу интерфейс с меньшим номером должен иметь более высокий приоритет. Если одновременно приходят операции записи и чтения по разным интерфейсам на один адрес, то все операции чтения считывают старое значение из ячеек.


A memory block for interacting with an abstract computer using 4 parallel synchronous interfaces. The word length is 8 bits. To prevent collisions with the "record" based on the same address, the interface with a lower number should have a higher priority. If at the same time write and read operations arrive at different addresses on the same address, then all read operations read the old value from the cells.
