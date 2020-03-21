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


def generateSample(background: Image, mPath, mList, numMatrices: int, fileName: str):
    bgW, bgH = background.size
    rW = bgW // 4
    rH = bgH // 4
    result = background.resize([rW, rH], Image.NEAREST)

    # Writer(path, width, height)
    writer = Writer(fileName, rW, rH)
    
    lastLeft = 0
    lastTop = random.randint(0, rH // 4)
    lastW = 0
    lastH = 4
    
    for i in range(numMatrices):
        imgName = random.choice(mList)
        mType: chr = imgName[0]
        annotation: str = 'Matrix'
        if mType != 'm':
            annotation = mType + annotation
        
        img = Image.open(mPath + '/' + imgName, 'r')
        imgW, imgH = img.size
        imgW = imgW // 4
        imgH = imgH // 4
        
        img = img.resize([imgW, imgH], Image.NEAREST)
        border = Image.new('RGB', (imgW + 12, imgH + 12), "white")
        
        left = lastLeft + lastW + random.randint(6, rW)
        
        if left + imgW > rW:
            left = random.randint(0, rW - imgW)
            top = lastTop + lastH + random.randint(6, rH - imgH)
        else:
            top = lastTop 
        
        offset = (left, top)
        borderOffset = (left - 6, top - 6)
        result.paste(border, borderOffset)
        result.paste(img, offset)
        
        writer.addObject(annotation, left, top, left + imgW, top + imgH)
        
        if top + imgH > rH:
            break
        
        lastLeft = left
        lastTop = top
        lastW = imgW
        lastH = imgH

    writer.save(resultXmlPath + '/' + fileName + ".xml")
    result.save(resultImgPath + '/' + fileName + ".png")
        
    
def generateDataset(numSamples: int, setName: str, bgFolder: str, mFolder: str):
    bgList = os.listdir(bgFolder)
    print(bgList)
    mList = os.listdir(mFolder)
    
    for i in range(numSamples):
        bgPath = bgFolder + '/' + random.choice(bgList)
        bgImg = Image.open(bgPath, 'r')
        
        numMatrices = random.randint(0, 6)
        fileName = setName + str(i)
        
        print(fileName)
        
        generateSample(bgImg, mFolder, mList, numMatrices, fileName)
        
generateDataset(10, "testset", BGPath, PMatrPath)
    
    
    

    

