# -*- coding: utf-8 -*-
"""
Created on Sat Dec 14 14:39:59 2019

@author: vital
"""

from PIL import Image
import os
import random
from pascal_voc_writer import Writer

    
    
HWMatrPath = './HandWrittenDataset/single'
PMatrPath = './PrintedDataset/test'
BGPath = './PBackgrounds'

resultImgPath = './SynthMultiMatr/img'
resultXmlPath = './SynthMultiMatr/xml'


def generateSample(background, mPath, mList, numMatrices: int, fileName: str):
    bgW, bgH = background.size
    # Writer(path, width, height)
    writer = Writer(fileName, bgW, bgH)
    
    for i in range(numMatrices):
        imgName = random.choice(mList)
        mType: chr = imgName[0]
        annotation: str = 'Matrix'
        if mType != 'm':
            annotation = mType + annotation
        
        img = Image.open(mPath + '/' + imgName, 'r')
        imgW, imgH = img.size
        
        offset = ((bgW - imgW) // 2, (bgH - imgH) // 2)
        background.paste(img, offset)
        
        writer.addObject('annotation', 100, 100, 200, 200)

    writer.save(resultXmlPath + '/' + fileName + ".xml")
    background.save(resultImgPath + '/' + fileName + ".png")
        
    
def generateDataset(numSamples: int, setName: str, bgFolder: str, mFolder: str):
    bgList = os.listdir(bgFolder)
    print(bgList)
    mList = os.listdir(mFolder)
    
    for i in range(numSamples):
        bgPath = bgFolder + '/' + random.choice(bgList)
        bgImg = Image.open(bgPath, 'r')
        
        numMatrices = random.randint(1, 8)
        fileName = setName + str(i)
        
        print(fileName)
        
        generateSample(bgImg, mFolder, mList, numMatrices, fileName)
        
generateDataset(10, "testset", BGPath, PMatrPath)
    
    
    

    

