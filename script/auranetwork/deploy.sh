#!/bin/bash

RED_COLOR='\033[0;31m'
GREEN_COLOR='\033[0;32m'
NO_COLOR='\033[0m'

if [ "$RPC_URL" = "" ]; then echo -e "${RED_COLOR}- Missing RPC_URL env variable"; return 1; fi
if [ "$WALLET_ADDRESS" = "" ]; then echo -e "${RED_COLOR}- Missing WALLET_ADDRESS env variable"; return 1; fi
if [ "$PRIVATE_KEY" = "" ]; then echo -e "${RED_COLOR}- Missing PRIVATE_KEY env variable"; return 1; fi
if [ "$VERIFIER_URL" = "" ]; then echo -e "${RED_COLOR}- Missing VERIFIER_URL env variable"; return 1; fi

# ====

if [ "$EIP2981_ROYALTY_OVERRIDE_CLONEABLE_ADDR" = "" ]
then
  echo -e "${NO_COLOR}Deploy EIP2981RoyaltyOverrideCloneable..."
  EIP2981_ROYALTY_OVERRIDE_CLONEABLE_DEPLOY_OUTPUT=$(forge create --rpc-url $RPC_URL --private-key $PRIVATE_KEY EIP2981RoyaltyOverrideCloneable \
    --verify --verifier sourcify --verifier-url $VERIFIER_URL)
  EIP2981_ROYALTY_OVERRIDE_CLONEABLE_ADDR=$(echo ${EIP2981_ROYALTY_OVERRIDE_CLONEABLE_DEPLOY_OUTPUT#*"Deployed to: "} | head -c 42)
  echo -e "${GREEN_COLOR}- deployed to: $EIP2981_ROYALTY_OVERRIDE_CLONEABLE_ADDR"

  if [[ $EIP2981_ROYALTY_OVERRIDE_CLONEABLE_DEPLOY_OUTPUT == *"Contract successfully verified"* ]]; then
    echo -e "${GREEN_COLOR}- verification result: success"
  elif [[ $EIP2981_ROYALTY_OVERRIDE_CLONEABLE_DEPLOY_OUTPUT == *"The recompiled contract partially matches the deployed version"* ]]; then
    echo -e "${GREEN_COLOR}- verification result: partially matches"
  else
    echo -e "${RED_COLOR}- fail to verify contract $EIP2981_ROYALTY_OVERRIDE_CLONEABLE_ADDR"
    echo -e "${RED_COLOR}$EIP2981_ROYALTY_OVERRIDE_CLONEABLE_DEPLOY_OUTPUT"
  fi
else
  echo -e "${NO_COLOR}Skip deploying EIP2981RoyaltyOverrideCloneable. Contract address provided ($EIP2981_ROYALTY_OVERRIDE_CLONEABLE_ADDR)"
fi

# ====

if [ "$EIP2981_MULTI_RECEIVER_ROYALTY_OVERRIDE_CLONEABLE_ADDR" = "" ]
then
  echo -e "${NO_COLOR}Deploy EIP2981MultiReceiverRoyaltyOverrideCloneable..."
  EIP2981_MULTI_RECEIVER_ROYALTY_OVERRIDE_CLONEABLE_DEPLOY_OUTPUT=$(forge create --rpc-url $RPC_URL --private-key $PRIVATE_KEY EIP2981MultiReceiverRoyaltyOverrideCloneable \
    --verify --verifier sourcify --verifier-url $VERIFIER_URL)
  EIP2981_MULTI_RECEIVER_ROYALTY_OVERRIDE_CLONEABLE_ADDR=$(echo ${EIP2981_MULTI_RECEIVER_ROYALTY_OVERRIDE_CLONEABLE_DEPLOY_OUTPUT#*"Deployed to: "} | head -c 42)
  echo -e "${GREEN_COLOR}- deployed to: $EIP2981_MULTI_RECEIVER_ROYALTY_OVERRIDE_CLONEABLE_ADDR"

  if [[ $EIP2981_MULTI_RECEIVER_ROYALTY_OVERRIDE_CLONEABLE_DEPLOY_OUTPUT == *"Contract successfully verified"* ]]; then
    echo -e "${GREEN_COLOR}- verification result: success"
  elif [[ $EIP2981_MULTI_RECEIVER_ROYALTY_OVERRIDE_CLONEABLE_DEPLOY_OUTPUT == *"The recompiled contract partially matches the deployed version"* ]]; then
    echo -e "${GREEN_COLOR}- verification result: partially matches"
  else
    echo -e "${RED_COLOR}- fail to verify contract $EIP2981_MULTI_RECEIVER_ROYALTY_OVERRIDE_CLONEABLE_ADDR"
    echo -e "${RED_COLOR}$EIP2981_MULTI_RECEIVER_ROYALTY_OVERRIDE_CLONEABLE_DEPLOY_OUTPUT"
  fi
else
  echo -e "${NO_COLOR}Skip deploying EIP2981MultiReceiverRoyaltyOverrideCloneable. Contract address provided ($EIP2981_MULTI_RECEIVER_ROYALTY_OVERRIDE_CLONEABLE_ADDR)"
fi

# ====

if [ "$ROYALTY_SPLITTER_ADDR" = "" ]
then
  echo -e "${NO_COLOR}Deploy RoyaltySplitter..."
  ROYALTY_SPLITTER_DEPLOY_OUTPUT=$(forge create --rpc-url $RPC_URL --private-key $PRIVATE_KEY RoyaltySplitter \
    --verify --verifier sourcify --verifier-url $VERIFIER_URL)
  ROYALTY_SPLITTER_ADDR=$(echo ${ROYALTY_SPLITTER_DEPLOY_OUTPUT#*"Deployed to: "} | head -c 42)
  echo -e "${GREEN_COLOR}- deployed to: $ROYALTY_SPLITTER_ADDR"

  if [[ $ROYALTY_SPLITTER_DEPLOY_OUTPUT == *"Contract successfully verified"* ]]; then
    echo -e "${GREEN_COLOR}- verification result: success"
  elif [[ $ROYALTY_SPLITTER_DEPLOY_OUTPUT == *"The recompiled contract partially matches the deployed version"* ]]; then
    echo -e "${GREEN_COLOR}- verification result: partially matches"
  else
    echo -e "${RED_COLOR}- fail to verify contract $ROYALTY_SPLITTER_ADDR"
    echo -e "${RED_COLOR}$ROYALTY_SPLITTER_DEPLOY_OUTPUT"
  fi
else
  echo -e "${NO_COLOR}Skip deploying RoyaltySplitter. Contract address provided ($ROYALTY_SPLITTER_ADDR)"
fi

# ====

if [ "$EIP2981_ROYALTY_OVERRIDE_FACTORY_ADDR" = "" ]
then
  echo -e "${NO_COLOR}Deploy EIP2981RoyaltyOverrideFactory..."
  EIP2981_ROYALTY_OVERRIDE_FACTORY_DEPLOY_OUTPUT=$(forge create --rpc-url $RPC_URL --private-key $PRIVATE_KEY EIP2981RoyaltyOverrideFactory \
    --constructor-args $EIP2981_MULTI_RECEIVER_ROYALTY_OVERRIDE_CLONEABLE_ADDR $EIP2981_MULTI_RECEIVER_ROYALTY_OVERRIDE_CLONEABLE_ADDR $ROYALTY_SPLITTER_ADDR \
    --verify --verifier sourcify --verifier-url $VERIFIER_URL)
  EIP2981_ROYALTY_OVERRIDE_FACTORY_ADDR=$(echo ${EIP2981_ROYALTY_OVERRIDE_FACTORY_DEPLOY_OUTPUT#*"Deployed to: "} | head -c 42)
  echo -e "${GREEN_COLOR}- deployed to: $EIP2981_ROYALTY_OVERRIDE_FACTORY_ADDR"

  if [[ $EIP2981_ROYALTY_OVERRIDE_FACTORY_DEPLOY_OUTPUT == *"Contract successfully verified"* ]]; then
    echo -e "${GREEN_COLOR}- verification result: success"
  elif [[ $EIP2981_ROYALTY_OVERRIDE_FACTORY_DEPLOY_OUTPUT == *"The recompiled contract partially matches the deployed version"* ]]; then
    echo -e "${GREEN_COLOR}- verification result: partially matches"
  else
    echo -e "${RED_COLOR}- fail to verify contract $EIP2981_ROYALTY_OVERRIDE_FACTORY_ADDR"
    echo -e "${RED_COLOR}$EIP2981_ROYALTY_OVERRIDE_FACTORY_DEPLOY_OUTPUT"
  fi
else
  echo -e "${NO_COLOR}Skip deploying EIP2981RoyaltyOverrideFactory. Contract address provided ($EIP2981_ROYALTY_OVERRIDE_FACTORY_ADDR)"
fi

# ====

if [ "$ROYALTY_REGISTRY_ADDR" = "" ]
then
  echo -e "${NO_COLOR}Deploy RoyaltyRegistry..."
  ROYALTY_REGISTRY_DEPLOY_OUTPUT=$(forge create --rpc-url $RPC_URL --private-key $PRIVATE_KEY RoyaltyRegistry \
    --constructor-args $EIP2981_ROYALTY_OVERRIDE_FACTORY_ADDR \
    --verify --verifier sourcify --verifier-url $VERIFIER_URL)
  ROYALTY_REGISTRY_ADDR=$(echo ${ROYALTY_REGISTRY_DEPLOY_OUTPUT#*"Deployed to: "} | head -c 42)
  echo -e "${GREEN_COLOR}- deployed to: $ROYALTY_REGISTRY_ADDR"

  if [[ $ROYALTY_REGISTRY_DEPLOY_OUTPUT == *"Contract successfully verified"* ]]; then
    echo -e "${GREEN_COLOR}- verification result: success"
  elif [[ $ROYALTY_REGISTRY_DEPLOY_OUTPUT == *"The recompiled contract partially matches the deployed version"* ]]; then
    echo -e "${GREEN_COLOR}- verification result: partially matches"
  else
    echo -e "${RED_COLOR}- fail to verify contract $ROYALTY_REGISTRY_ADDR"
    echo -e "${RED_COLOR}$ROYALTY_REGISTRY_DEPLOY_OUTPUT"
  fi
else
  echo -e "${NO_COLOR}Skip deploying RoyaltyRegistry. Contract address provided ($ROYALTY_REGISTRY_ADDR)"
fi

# ====

if [ "$FALL_BACK_REGISTRY_ADDR" = "" ]
then
  echo -e "${NO_COLOR}Deploy FallbackRegistry..."
  FALL_BACK_REGISTRY_DEPLOY_OUTPUT=$(forge create --rpc-url $RPC_URL --private-key $PRIVATE_KEY contracts/FallbackRegistry.sol:FallbackRegistry \
    --constructor-args "$WALLET_ADDRESS" `# initialOwner` \
    --verify --verifier sourcify --verifier-url $VERIFIER_URL)
  FALL_BACK_REGISTRY_ADDR=$(echo ${FALL_BACK_REGISTRY_DEPLOY_OUTPUT#*"Deployed to: "} | head -c 42)
  echo -e "${GREEN_COLOR}- deployed to: $FALL_BACK_REGISTRY_ADDR"

  if [[ $FALL_BACK_REGISTRY_DEPLOY_OUTPUT == *"Contract successfully verified"* ]]; then
    echo -e "${GREEN_COLOR}- verification result: success"
  elif [[ $FALL_BACK_REGISTRY_DEPLOY_OUTPUT == *"The recompiled contract partially matches the deployed version"* ]]; then
    echo -e "${GREEN_COLOR}- verification result: partially matches"
  else
    echo -e "${RED_COLOR}- fail to verify contract $FALL_BACK_REGISTRY_ADDR"
    echo -e "${RED_COLOR}$FALL_BACK_REGISTRY_DEPLOY_OUTPUT"
  fi
else
  echo -e "${NO_COLOR}Skip deploying FallbackRegistry. Contract address provided ($FALL_BACK_REGISTRY_ADDR)"
fi

# ====

if [ "$ROYALTY_ENGINE_ADDR" = "" ]
then
  echo -e "${NO_COLOR}Deploy RoyaltyEngineV1..."
  ROYALTY_ENGINE_DEPLOY_OUTPUT=$(forge create --rpc-url $RPC_URL --private-key $PRIVATE_KEY RoyaltyEngineV1 \
    --constructor-args $FALL_BACK_REGISTRY_ADDR \
    --verify --verifier sourcify --verifier-url $VERIFIER_URL)
  ROYALTY_ENGINE_ADDR=$(echo ${ROYALTY_ENGINE_DEPLOY_OUTPUT#*"Deployed to: "} | head -c 42)
  echo -e "${GREEN_COLOR}- deployed to: $ROYALTY_ENGINE_ADDR"

  if [[ $ROYALTY_ENGINE_DEPLOY_OUTPUT == *"Contract successfully verified"* ]]; then
    echo -e "${GREEN_COLOR}- verification result: success"
  elif [[ $ROYALTY_ENGINE_DEPLOY_OUTPUT == *"The recompiled contract partially matches the deployed version"* ]]; then
    echo -e "${GREEN_COLOR}- verification result: partially matches"
  else
    echo -e "${RED_COLOR}- fail to verify contract $ROYALTY_ENGINE_ADDR"
    echo -e "${RED_COLOR}$ROYALTY_ENGINE_DEPLOY_OUTPUT"
  fi
else
  echo -e "${NO_COLOR}Skip deploying RoyaltyEngineV1. Contract address provided ($ROYALTY_ENGINE_ADDR)"
fi

# ====

echo -e "${NO_COLOR}Initialize RoyaltyEngineV1..."
INITIALIZE_OUTPUT=$(cast send --rpc-url $RPC_URL --from $WALLET_ADDRESS --private-key $PRIVATE_KEY $ROYALTY_ENGINE_ADDR \
  "initialize(address,address)" "$WALLET_ADDRESS" "$ROYALTY_REGISTRY_ADDR")
INITIALIZE_STATUS=$(echo "$INITIALIZE_OUTPUT" | grep 'status' | awk '{print $2}')
if [ "$INITIALIZE_STATUS" = "1" ]
then
  INITIALIZE_TRANSACTION_HASH=$(echo "$INITIALIZE_OUTPUT" | grep -m 2 'transactionHash' | tail -n 1 | awk '{print $2}')
  echo -e "${GREEN_COLOR}- Royalty engine initialize success, tx hash: ${INITIALIZE_TRANSACTION_HASH}"
else
  echo -e "${RED_COLOR}- Royalty engine initialize fail"
fi
