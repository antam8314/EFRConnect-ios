//
//  SILGattConfigurationServiceEntitySpec.swift
//  BlueGeckoTests
//
//  Created by Grzegorz Janosz on 22/03/2021.
//  Copyright © 2021 SiliconLabs. All rights reserved.
//

@testable import BlueGecko

import Foundation
import Quick
import Nimble
import RealmSwift
import AEXML

class SILGattConfigurationModelSpec: QuickSpec {
    
    override func spec() {
        context("SILGattProjectEntity") {
            var projectEntity: SILGattProjectEntity!
            beforeEach {
                projectEntity = SILGattProjectEntity()
            }
            
            describe("getCopy()") {
                it("should copy object") {
                    projectEntity.additionalXmlAttributes.append(SILGattXMLAttribute(name: "device", value: "iOS"))
                    let copiedObject = projectEntity.getCopy()
                    expect(copiedObject._additionalXmlAttributes).to(equal(projectEntity._additionalXmlAttributes))
                    expect(copiedObject.additionalXmlChildren.count).to(equal(projectEntity.additionalXmlChildren.count))
                    expect(copiedObject.createdAt).notTo(equal(projectEntity.createdAt))
                    expect(copiedObject.uuid).notTo(equal(projectEntity.uuid))
                }
            }
        }
        
        context("SILGattConfigurationEntity") {
            var configurationEntity: SILGattConfigurationEntity!
            beforeEach {
                configurationEntity = SILGattConfigurationEntity()
            }
            
            describe("getCopy()") {
                it("should copy object") {
                    let testName = "test name"
                    let testServices = [SILGattConfigurationServiceEntity()]
                    configurationEntity.name = testName
                    configurationEntity.services.append(objectsIn: testServices)
                    configurationEntity.additionalXmlAttributes.append(SILGattXMLAttribute(name: "in", value: "true"))
                    let copiedObject = configurationEntity.getCopy()
                    expect(copiedObject.name).to(equal(testName))
                    expect(copiedObject.services.count).to(equal(testServices.count))
                    expect(copiedObject.additionalXmlAttributes.count).to(equal(configurationEntity.additionalXmlAttributes.count))
                    expect(copiedObject.createdAt).notTo(equal(configurationEntity.createdAt))
                    expect(copiedObject.uuid).notTo(equal(configurationEntity.uuid))
                }
            }
        }
        
        context("SILGattConfigurationServiceEntity") {
            var serviceEntity: SILGattConfigurationServiceEntity!
            beforeEach {
                serviceEntity = SILGattConfigurationServiceEntity()
            }
            
            describe("getCopy()") {
                it("should copy object") {
                    let testServiceName = "test name"
                    let testCBUUIDString = CBUUID().uuidString
                    let testIsPrimary = true
                    serviceEntity.name = testServiceName
                    serviceEntity.cbuuidString = testCBUUIDString
                    serviceEntity.isPrimary = testIsPrimary
                    let copiedObject = serviceEntity.getCopy()
                    expect(copiedObject.name).to(equal(testServiceName))
                    expect(copiedObject.cbuuidString).to(equal(testCBUUIDString))
                    expect(copiedObject.isPrimary).to(equal(testIsPrimary))
                    expect(copiedObject.createdAt).notTo(equal(serviceEntity.createdAt))
                    expect(copiedObject.uuid).notTo(equal(serviceEntity.uuid))
                }
            }
        }
        
        context("SILGattConfigurationCharacteristicEntity") {
            var characteristicEntity: SILGattConfigurationCharacteristicEntity!
            beforeEach {
                characteristicEntity = SILGattConfigurationCharacteristicEntity()
            }
            
            describe("getCopy()") {
                it("should copy object") {
                    let testName = "test name"
                    let testCBUUIDString = CBUUID().uuidString
                    let testProperties = [SILGattConfigurationProperty(type: .read, permission: .none)]
                    let testInitialValue = "test value"
                    let testInitialValueType: SILGattConfigurationValueType = .text
                    
                    characteristicEntity.name = testName
                    characteristicEntity.cbuuidString = testCBUUIDString
                    characteristicEntity.properties = testProperties
                    characteristicEntity.initialValue = testInitialValue
                    characteristicEntity.initialValueType = testInitialValueType
                    let copiedObject = characteristicEntity.getCopy()
                    expect(copiedObject.name).to(equal(testName))
                    expect(copiedObject.cbuuidString).to(equal(testCBUUIDString))
                    expect(copiedObject.properties).to(equal(testProperties))
                    expect(copiedObject.initialValue).to(equal(testInitialValue))
                    expect(copiedObject.initialValueType).to(equal(testInitialValueType))
                    expect(copiedObject.createdAt).notTo(equal(characteristicEntity.createdAt))
                    expect(copiedObject.uuid).notTo(equal(characteristicEntity.uuid))
                    expect(copiedObject.fixedVariableLength).to(equal(characteristicEntity.fixedVariableLength))
                }
            }
            
            describe("setting field properties") {
                it("should return the same properties as the ones was set") {
                    let testProperties = [SILGattConfigurationProperty(type: .read, permission: .none), SILGattConfigurationProperty(type: .indicate, permission: .bonded)]
                    characteristicEntity.properties = testProperties
                    expect(characteristicEntity.properties).to(equal(testProperties))
                }
                
                it("should proper set value of _properties") {
                    let testProperty1 = SILGattConfigurationProperty(type: .write, permission: .bonded)
                    let testProperty2 = SILGattConfigurationProperty(type: .notify, permission: .none)
                    let testProperties = [testProperty1, testProperty2]
                    characteristicEntity.properties = testProperties
                    let expectedValue = "\(testProperty1.type.rawValue):\(testProperty1.permission.rawValue),\(testProperty2.type.rawValue):\(testProperty2.permission.rawValue)"
                    expect(characteristicEntity._properties).to(equal(expectedValue))
                }
            }
        }
        
        context("SILGattConfigurationDescriptorEntity") {
            var descriptorEntity: SILGattConfigurationDescriptorEntity!
            beforeEach {
                descriptorEntity = SILGattConfigurationDescriptorEntity()
            }
            
            describe("getCopy()") {
                it("should copy object") {
                    let testName = "test name"
                    let testCBUUIDString = CBUUID().uuidString
                    let testProperties = [SILGattConfigurationProperty(type: .read, permission: .none)]
                    let testInitialValue = "test value"
                    let testInitialValueType: SILGattConfigurationValueType = .text
                    
                    descriptorEntity.name = testName
                    descriptorEntity.cbuuidString = testCBUUIDString
                    descriptorEntity.properties = testProperties
                    descriptorEntity.initialValue = testInitialValue
                    descriptorEntity.initialValueType = testInitialValueType
                    let copiedObject = descriptorEntity.getCopy()
                    expect(copiedObject.name).to(equal(testName))
                    expect(copiedObject.cbuuidString).to(equal(testCBUUIDString))
                    expect(copiedObject.properties).to(equal(testProperties))
                    expect(copiedObject.initialValue).to(equal(testInitialValue))
                    expect(copiedObject.initialValueType).to(equal(testInitialValueType))
                    expect(copiedObject.createdAt).notTo(equal(descriptorEntity.createdAt))
                    expect(copiedObject.uuid).notTo(equal(descriptorEntity.uuid))
                    expect(copiedObject.fixedVariableLength).to(equal(descriptorEntity.fixedVariableLength))
                }
            }
            
            describe("setting field properties") {
                it("should return the same properties as the ones was set") {
                    let testProperties = [SILGattConfigurationProperty(type: .read, permission: .none), SILGattConfigurationProperty(type: .indicate, permission: .bonded)]
                    descriptorEntity.properties = testProperties
                    expect(descriptorEntity.properties).to(equal(testProperties))
                }
                
                it("should proper set value of _properties") {
                    let testProperty1 = SILGattConfigurationProperty(type: .write, permission: .none)
                    let testProperty2 = SILGattConfigurationProperty(type: .read, permission: .none)
                    let testProperties = [testProperty1, testProperty2]
                    descriptorEntity.properties = testProperties
                    let expectedValue = "\(testProperty1.type.rawValue):\(testProperty1.permission.rawValue),\(testProperty2.type.rawValue):\(testProperty2.permission.rawValue)"
                    expect(descriptorEntity._properties).to(equal(expectedValue))
                }
            }
        }
        
        context("isEqualTo()") {
            var descriptorEntity: SILGattConfigurationDescriptorEntity!
            var characteristicEntity: SILGattConfigurationCharacteristicEntity!
            var serviceEntity: SILGattConfigurationServiceEntity!
            
            let descriptorTestName = "test name"
            let descriptorTestCBUUIDString = CBUUID().uuidString
            let descriptorTestProperties = [SILGattConfigurationProperty(type: .read, permission: .none)]
            let descriptorTestInitialValue = "test value"
            let descriptorTestInitialValueType: SILGattConfigurationValueType = .text
            
            let characteristicTestName = "test name"
            let characteristicTestCBUUIDString = CBUUID().uuidString
            let characteristicTestProperties = [SILGattConfigurationProperty(type: .read, permission: .none)]
            let characteristicTestInitialValue = "test value"
            let characteristicTestInitialValueType: SILGattConfigurationValueType = .text
            
            let serviceTestServiceName = "test name"
            let serviceTestCBUUIDString = CBUUID().uuidString
            let serviceTestIsPrimary = true
            
            beforeEach {
                descriptorEntity = SILGattConfigurationDescriptorEntity()
                characteristicEntity = SILGattConfigurationCharacteristicEntity()
                serviceEntity = SILGattConfigurationServiceEntity()
                
                descriptorEntity.name = descriptorTestName
                descriptorEntity.cbuuidString = descriptorTestCBUUIDString
                descriptorEntity.properties = descriptorTestProperties
                descriptorEntity.initialValue = descriptorTestInitialValue
                descriptorEntity.initialValueType = descriptorTestInitialValueType
                
                
                characteristicEntity.name = characteristicTestName
                characteristicEntity.cbuuidString = characteristicTestCBUUIDString
                characteristicEntity.properties = characteristicTestProperties
                characteristicEntity.initialValue = characteristicTestInitialValue
                characteristicEntity.initialValueType = characteristicTestInitialValueType
                
                serviceEntity.name = serviceTestServiceName
                serviceEntity.cbuuidString = serviceTestCBUUIDString
                serviceEntity.isPrimary = serviceTestIsPrimary
            }
            
            describe("SILGattConfigurationDescriptorEntity") {
                it("should return true for object with the same fields") {
                    
                    let sameFieldsDescriptor = SILGattConfigurationDescriptorEntity()
                    
                    sameFieldsDescriptor.name = descriptorTestName
                    sameFieldsDescriptor.cbuuidString = descriptorTestCBUUIDString
                    sameFieldsDescriptor.properties = descriptorTestProperties
                    sameFieldsDescriptor.initialValue = descriptorTestInitialValue
                    sameFieldsDescriptor.initialValueType = descriptorTestInitialValueType
                    expect(descriptorEntity.isEqualTo(sameFieldsDescriptor)).to(beTrue())
                }
                
                it("should return false for object with one different field") {
                    
                    let differentTestProperties = [SILGattConfigurationProperty(type: .write, permission: .none)]
                    
                    let sameFieldsDescriptor = SILGattConfigurationDescriptorEntity()
                    sameFieldsDescriptor.name = descriptorTestName
                    sameFieldsDescriptor.cbuuidString = descriptorTestCBUUIDString
                    sameFieldsDescriptor.initialValue = descriptorTestInitialValue
                    sameFieldsDescriptor.initialValueType = descriptorTestInitialValueType
                    
                    sameFieldsDescriptor.properties = differentTestProperties
                    
                    expect(descriptorEntity.isEqualTo(sameFieldsDescriptor)).to(beFalse())
                }
            }
            
            describe("SILGattConfigurationCharacteristicEntity") {
                it("should return true for object with the same fields") {
                    characteristicEntity.descriptors.append(descriptorEntity)
                    
                    let sameFieldCharacteristic = SILGattConfigurationCharacteristicEntity()
                    
                    sameFieldCharacteristic.name = characteristicTestName
                    sameFieldCharacteristic.cbuuidString = characteristicTestCBUUIDString
                    sameFieldCharacteristic.properties = characteristicTestProperties
                    sameFieldCharacteristic.initialValue = characteristicTestInitialValue
                    sameFieldCharacteristic.initialValueType = characteristicTestInitialValueType
                    sameFieldCharacteristic.descriptors.append(descriptorEntity)
                    
                    expect(characteristicEntity.isEqualTo(sameFieldCharacteristic)).to(beTrue())
                }
                
                it("should return false when descriptor inside has different field") {
                    characteristicEntity.descriptors.append(descriptorEntity)
                    
                    let differentFieldCharacteristic = SILGattConfigurationCharacteristicEntity()
                    
                    differentFieldCharacteristic.name = characteristicTestName
                    differentFieldCharacteristic.cbuuidString = characteristicTestCBUUIDString
                    differentFieldCharacteristic.properties = characteristicTestProperties
                    differentFieldCharacteristic.initialValue = characteristicTestInitialValue
                    differentFieldCharacteristic.initialValueType = characteristicTestInitialValueType
                    
                    let changedDescriptor = SILGattConfigurationDescriptorEntity(value: descriptorEntity)
                    changedDescriptor.name = "different name"
                    differentFieldCharacteristic.descriptors.append(changedDescriptor)
                    
                    expect(characteristicEntity.isEqualTo(differentFieldCharacteristic)).to(beFalse())
                }
            }
            
            describe("SILGattConfigurationServiceEntity") {
                it("should return true for object with the same fields") {
                    characteristicEntity.descriptors.append(descriptorEntity)
                    serviceEntity.characteristics.append(characteristicEntity)
                    
                    let sameFieldService = SILGattConfigurationServiceEntity()
                    
                    sameFieldService.name = serviceTestServiceName
                    sameFieldService.cbuuidString = serviceTestCBUUIDString
                    sameFieldService.isPrimary = serviceTestIsPrimary
                    sameFieldService.characteristics.append(characteristicEntity)
                    
                    expect(serviceEntity.isEqualTo(sameFieldService)).to(beTrue())
                }
                
                it("should return false when characteristic inside has different field") {
                    characteristicEntity.descriptors.append(descriptorEntity)
                    serviceEntity.characteristics.append(characteristicEntity)
                    
                    let differentFieldService = SILGattConfigurationServiceEntity()
                    
                    differentFieldService.name = serviceTestServiceName
                    differentFieldService.cbuuidString = serviceTestCBUUIDString
                    differentFieldService.isPrimary = serviceTestIsPrimary
                    
                    let changedCharacteristic = SILGattConfigurationCharacteristicEntity(value: characteristicEntity)
                    changedCharacteristic.initialValueType = .hex
                    changedCharacteristic.initialValue = "fafafafa54"
                    differentFieldService.characteristics.append(changedCharacteristic)
                    
                    expect(serviceEntity.isEqualTo(differentFieldService)).to(beFalse())
                }
            }
            
            describe("SILGattConfigurationEntity") {
                it("should return true for object with the same fields") {
                    let testName = "entity name"
                    
                    let entity = SILGattConfigurationEntity()
                    entity.name = testName
                    entity.services.append(serviceEntity)
                    
                    let sameFieldEntity = SILGattConfigurationEntity()
                    sameFieldEntity.name = testName
                    sameFieldEntity.services.append(serviceEntity)
                    
                    expect(entity.isEqualTo(sameFieldEntity)).to(beTrue())
                }
                
                it("should return false when characteristic inside has different field") {
                    let testName = "entity name"
                    
                    let entity = SILGattConfigurationEntity()
                    entity.name = testName
                    entity.services.append(serviceEntity)
                    
                    let differentFieldEntity = SILGattConfigurationEntity()
                    differentFieldEntity.name = testName
                    differentFieldEntity.services.append(serviceEntity)
                    differentFieldEntity.services.append(SILGattConfigurationServiceEntity())
                    
                    expect(entity.isEqualTo(differentFieldEntity)).to(beFalse())
                }
            }
        }
        
        context("SILGattXMLAttribute") {
            var attribute: SILGattXMLAttribute!
            let testName = "test_name"
            let testValue = "test_value"
            
            describe("init from pairString") {
                it("should have set proper fields from pairString") {
                    let pairString = "\(testName):\(testValue)"
                    attribute = SILGattXMLAttribute(pairString: pairString)
                    expect(attribute.name).to(equal(testName))
                    expect(attribute.value).to(equal(testValue))
                }
                
                it("should be equal attributes when create from getPairString()") {
                    attribute = SILGattXMLAttribute(name: "other_name", value: "other_value")
                    let attributeToCompare = SILGattXMLAttribute(pairString: attribute.getPairString())
                    expect(attribute.name).to(equal(attributeToCompare.name))
                    expect(attribute.value).to(equal(attributeToCompare.value))
                }
            }
            
            describe("getPairString()") {
                it("should return string in proper format") {
                    attribute = SILGattXMLAttribute(name: testName, value: testValue)
                    expect(attribute.getPairString()).to(equal("test_name:test_value"))
                }
            }
        }
        
        context("SILGattXmlNodeInfo") {
            describe("_additionalXmlAttributes") {
                var entity: SILGattConfigurationCharacteristicEntity!
                beforeEach {
                    entity = SILGattConfigurationCharacteristicEntity()
                }
                
                it("should be proper set when set additionalXmlAttributes") {
                    let testXMLAttributes = [SILGattXMLAttribute(pairString: "name1:val1"), SILGattXMLAttribute(pairString: "name2:val2")]
                    entity.additionalXmlAttributes = testXMLAttributes
                    expect(entity.additionalXmlAttributes.count).to(equal(2))
                    expect(entity.additionalXmlAttributes).to(containElementSatisfying({ $0.getPairString() == "name1:val1" }))
                    expect(entity.additionalXmlAttributes).to(containElementSatisfying({ $0.getPairString() == "name2:val2" }))
                    expect(entity._additionalXmlAttributes).to(equal("name1:val1:::name2:val2"))
                }
            }
            
            describe("_additionalXmlChildren") {
                var entity: SILGattConfigurationCharacteristicEntity!
                beforeEach {
                    entity = SILGattConfigurationCharacteristicEntity()
                }
                
                it("should be proper set when set additionalXmlChildren") {
                    let firstXMLElement = AEXMLElement(name: "name", value: "val", attributes: ["attr": "attr_val"])
                    let secondXMLElement = AEXMLElement(name: "name2", value: "val2", attributes: ["attr2": "attr_val2"])
                    let testXMLAttributes = [firstXMLElement, secondXMLElement]
                    entity.additionalXmlChildren = testXMLAttributes
                    expect(entity.additionalXmlChildren.count).to(equal(2))
                    expect(entity.additionalXmlChildren).to(containElementSatisfying({ $0.xml == firstXMLElement.xml }))
                    expect(entity.additionalXmlChildren).to(containElementSatisfying({ $0.xml == secondXMLElement.xml }))
                    expect(entity._additionalXmlChildren).to(equal("\(firstXMLElement.xml):::\(secondXMLElement.xml)"))
                }
            }
        }
    }
}
