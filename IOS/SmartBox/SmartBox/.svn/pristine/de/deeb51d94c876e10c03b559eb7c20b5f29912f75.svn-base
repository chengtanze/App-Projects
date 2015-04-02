/*
 *  Utility.c
 *  inCarTime
 *
 *  Created by PippoTan on 11-7-5.
 *  Copyright 2011 __MyCompanyName__. All rights reserved.
 *
 */

#include "Utility.h"

#define TEA_DELTA	0x9E3779B9
#define TEA_SUM		0xE3779B90

void tinyEncrypt ( const unsigned int * plain, const unsigned int * key, unsigned int *crypt, unsigned int power)
{
    unsigned int y,z,a,b,c,d;
    unsigned int sum = 0;
    unsigned int i;
    unsigned int rounds = 1<<power;
	
    y = plain[0];
    z = plain[1];
    a = key[0];
    b = key[1];
    c = key[2];
    d = key[3];
	
    for (i = 0; i < rounds; i++) {
        sum += TEA_DELTA;
        y += ((z << 4) + a) ^ (z + sum) ^ ((z >> 5) + b);
        z += ((y << 4) + c) ^ (y + sum) ^ ((y >> 5) + d);
    }
	
    crypt[0] = y;
    crypt[1] = z;
}


void tinyDecrypt ( const unsigned int * crypt, const unsigned int * key, unsigned int *plain, unsigned int power)
{
    unsigned int y,z,a,b,c,d;
    unsigned int rounds = 1<<power;
    unsigned int sum = TEA_DELTA<<power;
    unsigned int i;
    
    const uint16_t * tcrpt = (const uint16_t *)crypt;
    
    uint16_t x = tcrpt[0];
    uint16_t j = tcrpt[1];
    y = j*16*16*16*16+x;
    //printf("y === %u,crypt[0] == %u",y,crypt[0]);
	
    ///y = crypt[0];
    z = crypt[1];
    a = key[0];
    b = key[1];
    c = key[2];
    d = key[3];
	
    for (i = 0; i < rounds; i++) {
        z -= ((y << 4) + c) ^ (y + sum) ^ ((y >> 5) + d);
        y -= ((z << 4) + a) ^ (z + sum) ^ ((z >> 5) + b);
        sum -= TEA_DELTA;
    }
	
    plain[0] = y;
    plain[1] = z;
}

/*================================================================
 *
 * 函 数 名：xTEADecryptWithKey
 ** Decrypt the cipher text to plain text with the key
 
 * 参 数：
 *
 * const unsigned long *crypt [IN] : the Cipher text
 * DWORD dwCryptLen[IN]: cipher text length
 * const unsigned long *theKey [IN] : the key
 * DWORD dwKeyLen[IN]: key length
 * unsigned long *plain [[IN,OUT]] : the pointer to plain text(net order byte)
 * DWORD * pdwPlainLen[IN,OUT]: Valid plain text length
 *
 * 返 回 值：BOOL-	SUCCESS:TRUE
 *							Fail:NULL
 *
 *
 ================================================================*/
bool xTEADecryptWithKey(const char *crypt, unsigned int crypt_len,const char key[16], char *plain, unsigned int * plain_len)
{
	if(crypt == NULL || plain == NULL)
		return FALSE;
	const unsigned int *tkey   = (const unsigned int *)key;
	const unsigned int *tcrypt = (const unsigned int *)crypt;
	
	if( crypt_len<1 || crypt_len%8 )
		return FALSE;
	
	int *tplain = new int[crypt_len/4+1];
	
	unsigned int  length = crypt_len;
	unsigned int pre_plain[2] = {0,0};
	unsigned int p_buf[2] = {0};
	unsigned int c_buf[2] = {0};
	
	int padLength = 0;
	int i = 0;
	
	//Decrypt the first 8 bytes(64 bits)
	tinyDecrypt(tcrypt, tkey, p_buf, 4);
	
	memcpy(pre_plain, p_buf, 8);
	memcpy(tplain, p_buf, 8);
	
	//Decrype with TEA and interlace algorithm
	for (i = 2; i < (int)length/4; i+=2) {
		c_buf[0] = *(tcrypt+i) ^ pre_plain[0];
		c_buf[1] = *(tcrypt+i+1) ^ pre_plain[1];
		tinyDecrypt((const unsigned int *)c_buf, tkey, p_buf, 4);
		memcpy(pre_plain, p_buf, 8);
		*(tplain+i) = p_buf[0] ^ *(tcrypt+i-2);
		*(tplain+i+1) = p_buf[1] ^ *(tcrypt+i-1);
	}
	
	//check the last 7 bytes is 0x00
	if ( tplain[length/4-1] || (tplain[length/4-2]&0xffffff00))
	{
		delete[] tplain; tplain = NULL;
		return FALSE;
	}
	
	padLength = *((unsigned char *)tplain) & 0x07;
	
	length = (length / 4 + 1)*4 - (padLength+3);  //add by zyf
	//Remove padding data
	memcpy(tplain,(unsigned char*)tplain+padLength+3,length);
	
	*plain_len = crypt_len - (padLength+3) -7;/*(pad 7 bytes 0x00 at the end)*/
	
	memcpy(plain,tplain,*plain_len);
	
	
	delete [] tplain; tplain = NULL;
	
	return TRUE;
	
}
/*================================================================
 *
 * 函 数 名：xTEAEncryptWithKey
 ** Encrypt the plain text to cipher text with the key
 
 * 参 数：
 *
 * const unsigned long *plain [IN] : the plain text
 * DWORD dwPlainLen[IN]: plain text length
 * const unsigned long *theKey [IN] : the key
 * DWORD dwKeyLen[IN]: key length
 * unsigned long *crypt [[IN,OUT]] : the pointer to cipher text(net order byte)
 * DWORD * pdwCryptLen[IN,OUT]: Valid cipher text length
 *
 * 返 回 值：BOOL-	SUCCESS:TRUE
 *							Fail:NULL
 *
 *
 ================================================================*/

bool xTEAEncryptWithKey(const char *plain, unsigned int plain_len, const char key[16], char *crypt, unsigned int * crypt_len )
{
	if(plain == NULL || crypt == NULL)
		return FALSE;
	const unsigned char pad[9] = {0xad,0xad,0xad,0xad,0xad,0xad,0xad,0xad,0xad};
	
	unsigned int *tkey = (unsigned int *)key;
	unsigned int *tplain = (unsigned int *)plain;
	
	if ( plain_len<1 )
	{
		return FALSE;
	}
	
	unsigned int pre_plain[2] = {0,0};
	unsigned int pre_crypt[2] = {0,0};
	unsigned int p_buf[2] = {0};
	unsigned int c_buf[2] = {0};
	
	int padLength = 0;
	int i = 0;
	
	// padding data
	padLength = (plain_len+10)%8;//at least pad 2 bytes
	padLength = padLength ? 8 - padLength : 0;//total pad length -2
	
	int length = padLength+3+plain_len+7;
	*crypt_len = length;
	
	int *tcrypt = new int[length/4];
	
	*((unsigned char*)tcrypt) = 0xa8 | (unsigned char)padLength;//first pad byte: total padding bytes - 2 or 0xa8
	memcpy ( (unsigned char*)tcrypt+1, (unsigned char*)pad, padLength+2);//add other padding data
	memcpy ( (unsigned char*)tcrypt+padLength+3, (unsigned char*)tplain, plain_len);//add plain data
	memset ( (unsigned char*)tcrypt+padLength+3+plain_len, 0, 7);  //pad 7 0x00 at the end
	
	//Interlace algorithm(交织算法)
	for (i = 0; i < length/4; i+=2) {
		p_buf[0] = *(tcrypt+i) ^ pre_crypt[0];
		p_buf[1] = *(tcrypt+i+1) ^ pre_crypt[1];
		tinyEncrypt( p_buf, tkey, c_buf, 4);
		*(tcrypt+i) = c_buf[0] ^ pre_plain[0];
		*(tcrypt+i+1) = c_buf[1] ^ pre_plain[1];
		memcpy(pre_crypt, tcrypt+i, 8);
		memcpy(pre_plain, p_buf, 8);
	}
	
	memcpy(crypt,tcrypt,length);
	
	delete []tcrypt; tcrypt = NULL;
	
	return TRUE;
	
}


